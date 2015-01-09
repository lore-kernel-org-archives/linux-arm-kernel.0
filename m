From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 9 Jan 2015 21:45:22 +0100
Subject: [RFC 02/11] i2c: add quirk checks to core
In-Reply-To: <54B02D7F.7040501@cogentembedded.com>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
 <1420824103-24169-3-git-send-email-wsa@the-dreams.de>
 <54B02D7F.7040501@cogentembedded.com>
Message-ID: <20150109204522.GB1904@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 10:35:27PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 01/09/2015 08:21 PM, Wolfram Sang wrote:
> 
> >Let the core do the checks if HW quirks prevent a transfer. Saves code
> >from drivers and adds consistency.
> 
> >Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> >---
> >  drivers/i2c/i2c-core.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >
> >diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> >index 39d25a8cb1ad..7b10a19abf5b 100644
> >--- a/drivers/i2c/i2c-core.c
> >+++ b/drivers/i2c/i2c-core.c
> >@@ -2063,6 +2063,56 @@ module_exit(i2c_exit);
> >   * ----------------------------------------------------
> >   */
> >
> >+/* Check if val is exceeding the quirk IFF quirk is non 0 */
> >+#define i2c_quirk_exceeded(val, quirk) ((quirk) && ((val) > (quirk)))
> >+
> >+static int i2c_quirk_error(struct i2c_adapter *adap, struct i2c_msg *msg, char *err_msg)
> >+{
> >+	dev_err(&adap->dev, "quirk: %s (addr 0x%04x, size %u)\n", err_msg, msg->addr, msg->len);
> >+	return -EOPNOTSUPP;
> >+}
> 
>    Always returning the same value doesn't make much sense. Are you trying
> to save space on the call sites?

Please elaborate. I think it does. If a quirk matches, we report that we
don't support this transfer.

> [...]
> >@@ -2080,6 +2130,9 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> >  	unsigned long orig_jiffies;
> >  	int ret, try;
> >
> >+	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))
> 
>    So, you only check for non-zero result of this function? Perhaps it makes
> sense to return true/false instead?

Could be done, but what would be the advantage? A lot of functions
return errno or 0.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150109/6a035f82/attachment-0001.sig>
