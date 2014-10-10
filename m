From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 10 Oct 2014 20:12:21 +0200
Subject: [RFC] drop owner assignment from platform_drivers
In-Reply-To: <2106140.DbuFLh1xav@wuerfel>
References: <20141010072439.GA1741@katana>
 <2106140.DbuFLh1xav@wuerfel>
Message-ID: <20141010181218.GB6075@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

thanks for taking a look!

On Fri, Oct 10, 2014 at 10:30:08AM +0200, Arnd Bergmann wrote:
> On Friday 10 October 2014 09:24:39 Wolfram Sang wrote:
> > people found out that for platform_driver, we don't need to set the
> > .owner field because this is done by the platform driver core. So far,
> > so good. However, now I got patches removing the .owner field for this
> > single i2c driver or for that one. To prevent getting thousands of
> > patches fixing single drivers, I used coccinelle to remove all instances
> > from the kernel. The SmPL looks like this, it doesn't blindly remove all
> > THIS_MODULE, but checks if the platform_driver struct was really used by
> > a call actually setting the .owner field:
> 
> Is the intention just to save a few lines in the kernel source, or are
> there any additional upsides to doing this?

As written above, I don't like getting patches removing this line for
single drivers. I already got two and I am expecting more. So I'd prefer
to do this on subsystem level. I will apply the I2C part, for sure.

> While it looks like an obvious cleanup, it also seems to me that there
> is zero effect in terms of functionality, code size or enabling future
> changes.

Well, the kernel image will compress better ;) And well, it is cleaner.
Why should we set up something if it gets overwritten anyhow?

> I'm all for adding your semantic patch to scripts/coccinelle so it gets
> picked up by anyone writing new drivers or doing code cleanup on their
> driver, but I'm unsure about the value of applying all your patches
> for the existing drivers.

I could try reducing the number of patches. Any other downsides?

Thanks,

   Wolfram
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141010/39384089/attachment.sig>
