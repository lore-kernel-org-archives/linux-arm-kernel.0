From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 4 May 2016 03:32:12 +0200
Subject: [PATCH 02/12] eeprom: at24: remove nvmem regmap dependency
In-Reply-To: <20160502073254.GA2015@tetsubishi>
References: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1461526096-29584-3-git-send-email-srinivas.kandagatla@linaro.org>
 <20160502073254.GA2015@tetsubishi>
Message-ID: <20160504013212.GA7972@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2016 at 09:32:54AM +0200, Wolfram Sang wrote:
> On Sun, Apr 24, 2016 at 08:28:06PM +0100, Srinivas Kandagatla wrote:
> > This patch moves to nvmem support in the driver to use callback instead
> > of regmap.
> > 
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Andrew, since you did the NVMEM implementation, could you have a look at
> this? That would be awesome. Thanks!
> 
> > ---
> >  drivers/misc/eeprom/Kconfig |   1 -
> >  drivers/misc/eeprom/at24.c  | 103 ++++++++++----------------------------------
> >  2 files changed, 22 insertions(+), 82 deletions(-)
> > 
> > diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
> > index cfc493c..2d70464 100644
> > --- a/drivers/misc/eeprom/Kconfig
> > +++ b/drivers/misc/eeprom/Kconfig
> > @@ -3,7 +3,6 @@ menu "EEPROM support"
> >  config EEPROM_AT24
> >  	tristate "I2C EEPROMs / RAMs / ROMs from most vendors"
> >  	depends on I2C && SYSFS
> > -	select REGMAP
> >  	select NVMEM
> >  	help
> >  	  Enable this driver to get read/write support to most I2C EEPROMs
> > diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> > index 089d694..de550a6 100644
> > --- a/drivers/misc/eeprom/at24.c
> > +++ b/drivers/misc/eeprom/at24.c
> > @@ -23,7 +23,6 @@
> >  #include <linux/acpi.h>
> >  #include <linux/i2c.h>
> >  #include <linux/nvmem-provider.h>
> > -#include <linux/regmap.h>
> >  #include <linux/platform_data/at24.h>
> >  
> >  /*
> > @@ -69,7 +68,6 @@ struct at24_data {
> >  	unsigned write_max;
> >  	unsigned num_addresses;
> >  
> > -	struct regmap_config regmap_config;
> >  	struct nvmem_config nvmem_config;
> >  	struct nvmem_device *nvmem;
> >  
> > @@ -252,10 +250,10 @@ static ssize_t at24_eeprom_read(struct at24_data *at24, char *buf,
> >  	return -ETIMEDOUT;
> >  }
> >  
> > -static ssize_t at24_read(struct at24_data *at24,
> > -		char *buf, loff_t off, size_t count)
> > +static int at24_read(void *priv, unsigned int off, void *val, size_t count)
> >  {
> > -	ssize_t retval = 0;
> > +	struct at24_data *at24 = priv;
> > +	char *buf = val;
> >  
> >  	if (unlikely(!count))
> >  		return count;
> > @@ -267,23 +265,21 @@ static ssize_t at24_read(struct at24_data *at24,
> >  	mutex_lock(&at24->lock);
> >  
> >  	while (count) {
> > -		ssize_t	status;
> > +		int	status;
> >  
> >  		status = at24_eeprom_read(at24, buf, off, count);

Since the patch replaces ssize_t with int here, it would also make
sense to do the same to at24_eeprom_read and at24_eeprom_write. Either
use ssize_t everywhere or nowhere.

      Andrew
