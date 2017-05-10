From: joel@jms.id.au (Joel Stanley)
Date: Wed, 10 May 2017 17:43:02 +0930
Subject: [PATCH v6 10/23] drivers/fsi: Add device read/write/peek API
In-Reply-To: <20170410194706.64280-11-cbostic@linux.vnet.ibm.com>
References: <20170410194706.64280-1-cbostic@linux.vnet.ibm.com>
 <20170410194706.64280-11-cbostic@linux.vnet.ibm.com>
Message-ID: <CACPK8Xewjnpvc3sN=X9tMm7NP6rQ=NHKDuxwYO4DFjRw63PP8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 11, 2017 at 5:16 AM, Christopher Bostic
<cbostic@linux.vnet.ibm.com> wrote:
> From: Jeremy Kerr <jk@ozlabs.org>
>
> This change introduces the fsi device API: simple read, write and peek
> accessors for the devices' address spaces.
>
> Includes contributions from Chris Bostic <cbostic@linux.vnet.ibm.com>
> and Edward A. James <eajames@us.ibm.com>.
>
> Signed-off-by: Edward A. James <eajames@us.ibm.com>
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> Signed-off-by: Chris Bostic <cbostic@linux.vnet.ibm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/fsi/fsi-core.c | 33 +++++++++++++++++++++++++++++++++
>  include/linux/fsi.h    |  7 ++++++-
>  2 files changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> index a8faa89..4da0b030 100644
> --- a/drivers/fsi/fsi-core.c
> +++ b/drivers/fsi/fsi-core.c
> @@ -32,6 +32,8 @@
>  #define FSI_SLAVE_CONF_CRC_MASK                0x0000000f
>  #define FSI_SLAVE_CONF_DATA_BITS       28
>
> +#define FSI_PEEK_BASE                  0x410
> +
>  static const int engine_page_size = 0x400;
>
>  #define FSI_SLAVE_BASE                 0x800
> @@ -73,9 +75,40 @@ static int fsi_master_read(struct fsi_master *master, int link,
>                 uint8_t slave_id, uint32_t addr, void *val, size_t size);
>  static int fsi_master_write(struct fsi_master *master, int link,
>                 uint8_t slave_id, uint32_t addr, const void *val, size_t size);
> +static int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
> +               void *val, size_t size);
> +static int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
> +               const void *val, size_t size);

I don't think these
>
>  /* FSI endpoint-device support */
>
> +int fsi_device_read(struct fsi_device *dev, uint32_t addr, void *val,
> +               size_t size)

I suggest adding some comments about the use of fsi_device_read,
fsi_device_write and fsi_device_peek APIs for driver authors.

One important note is that the data in val must be FSI bus endian (big endian).

It would be nice to have the sparse notation (eg. __be32) as well.
That doesn't make sense for void *, but we could add some helper
functions like:

 int fsi_device_read32(struct fsi_device *dev, uint32_t addr, __be32 *val)

 int fsi_device_write32(struct fsi_device *dev, uint32_t addr, __be32 val)

We probably only need a 32 bit version, as all of the reads/writes
being done in users of this function are 32 bit.

What do you think?

> +{
> +       if (addr > dev->size || size > dev->size || addr > dev->size - size)
> +               return -EINVAL;
> +
> +       return fsi_slave_read(dev->slave, dev->addr + addr, val, size);
> +}
> +EXPORT_SYMBOL_GPL(fsi_device_read);
> +
> +int fsi_device_write(struct fsi_device *dev, uint32_t addr, const void *val,
> +               size_t size)
> +{
> +       if (addr > dev->size || size > dev->size || addr > dev->size - size)
> +               return -EINVAL;
> +
> +       return fsi_slave_write(dev->slave, dev->addr + addr, val, size);
> +}
> +EXPORT_SYMBOL_GPL(fsi_device_write);
> +
> +int fsi_device_peek(struct fsi_device *dev, void *val)
> +{
> +       uint32_t addr = FSI_PEEK_BASE + ((dev->unit - 2) * sizeof(uint32_t));
> +
> +       return fsi_slave_read(dev->slave, addr, val, sizeof(uint32_t));
> +}
> +
>  static void fsi_device_release(struct device *_device)
>  {
>         struct fsi_device *device = to_fsi_dev(_device);
> diff --git a/include/linux/fsi.h b/include/linux/fsi.h
> index efa55ba..66bce48 100644
> --- a/include/linux/fsi.h
> +++ b/include/linux/fsi.h
> @@ -27,6 +27,12 @@ struct fsi_device {
>         uint32_t                size;
>  };
>
> +extern int fsi_device_read(struct fsi_device *dev, uint32_t addr,
> +               void *val, size_t size);
> +extern int fsi_device_write(struct fsi_device *dev, uint32_t addr,
> +               const void *val, size_t size);
> +extern int fsi_device_peek(struct fsi_device *dev, void *val);
> +
>  struct fsi_device_id {
>         u8      engine_type;
>         u8      version;
> @@ -40,7 +46,6 @@ struct fsi_device_id {
>  #define FSI_DEVICE_VERSIONED(t, v) \
>         .engine_type = (t), .version = (v),
>
> -
>  struct fsi_driver {
>         struct device_driver            drv;
>         const struct fsi_device_id      *id_table;
> --
> 1.8.2.2
>
