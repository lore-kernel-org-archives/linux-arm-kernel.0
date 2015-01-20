From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 20 Jan 2015 12:35:08 +0100
Subject: [PATCH] i2c: drop ancient protection against sysfs refcounting
 issues
In-Reply-To: <20150120101752.GI26493@n2100.arm.linux.org.uk>
References: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
 <20150119190142.GA9451@kroah.com>
 <20150119230427.GH26493@n2100.arm.linux.org.uk>
 <20150120014159.GA3349@kroah.com> <54BDFE30.5090303@metafoo.de>
 <20150120071256.GA18983@kroah.com>
 <20150120101752.GI26493@n2100.arm.linux.org.uk>
Message-ID: <20150120113508.GA1067@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Right, and I'm not saying it should be, just move the existing logic
> > into the release callback, and the code flow should be the same and we
> > don't end up with an "empty" release callback.

But as Russell says, even if we don't have the empty callback, we still
create the problem shown by DEBUG_KOBJECT_RELEASE which wasn't there
before?

> IMHO there are two possibilities here:
> 
> 1. leave it as-is, where we ensure that the remainder of i2c_del_adapter
>    does not complete until the release callback has been called.
> 
> 2. fix it properly by taking (eg) the netdev approach to i2c_adapter,
>    or an alternative solution which results in decoupling the lifetime
>    of the struct device from the i2c_adapter.
> 
> Either of these would be much better than removing the completion and
> then moving a chunk of code to make it "look" safer than it actually is
> and thereby introducing potential use-after-free bugs.

I agree. As much as I'd love option 2) I don't see that on the horizon.
So, let's keep things as they are. What probably makes sense is to
update the comment with something like this? I took the liberty and used
some wording from Russell:

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index e227dff62a85..1c89a08fae2a 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1778,11 +1778,14 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 	/* device name is gone after device_unregister */
 	dev_dbg(&adap->dev, "adapter [%s] unregistered\n", adap->name);
 
-	/* clean up the sysfs representation */
+	/* wait until all references to the device are gone
+	 *
+	 * FIXME: This is old code and should ideally be replaced by an
+	 * alternative which results in decoupling the lifetime of the struct
+	 * device from the i2c_adapter, like spi or netdev do.
+	 */
 	init_completion(&adap->dev_released);
 	device_unregister(&adap->dev);
-
-	/* wait for sysfs to drop all references */
 	wait_for_completion(&adap->dev_released);
 
 	/* free bus id */


Thanks for all the input, it is very much appreciated!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150120/69ff1196/attachment.sig>
