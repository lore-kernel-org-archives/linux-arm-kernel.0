From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 31 Mar 2012 13:25:18 +0800
Subject: [PATCH] ARM: amba: adapt to regulator probe deferral change
In-Reply-To: <20120330180134.GJ22981@n2100.arm.linux.org.uk>
References: <1333115737-1654-1-git-send-email-shawn.guo@linaro.org>
 <20120330180134.GJ22981@n2100.arm.linux.org.uk>
Message-ID: <20120331052516.GK3254@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 07:01:34PM +0100, Russell King - ARM Linux wrote:
> On Fri, Mar 30, 2012 at 09:55:37PM +0800, Shawn Guo wrote:
> > The commit 04bf301 (regulator: Support driver probe deferral) changes
> > regulator_get() and regulator_register() to return -EPROBE_DEFER
> > instead of -ENODEV.  Adapt amba bus driver to the change, otherwise
> > amba_probe() will fail on the platforms that do not have "vcore"
> > regulator device.
> 
> Are you sure this is correct?  Did you read and understand the comment
> you removed?
> 
I did read the comment and try to understand it.  Correct me if the
understanding below is wrong.

> What do platforms do which have AMBA devices but don't have any vcore
> regulators?
> 
We will have two cases for platforms that do not have any vcore
regulators.

1) CONFIG_REGULATOR is not enabled

   The regulator_get() returns NULL, and regulator_enable() returns 0.
   amba_get_enable_vcore() will succeed with 'ret' as 0.  My patch
   changes nothing for this case.

2) CONFIG_REGULATOR is enabled but platform never registers any vcore
   regulators

   Before commit 04bf301 (regulator: Support driver probe deferral),
   regulator_get() returns ERR_PTR(-ENODEV) when no "vore" regulator
   is found, and the check "if (PTR_ERR(vcore) == -ENODEV)" in
   amba_get_enable_vcore() forces a success return.   Now that commit
   changes regulator_get() to returns ERR_PTR(-EPROBE_DEFER) in case
   that no "vore" regulator is found.  My patch changes the check in
   amba_get_enable_vcore() from -ENODEV to -EPROBE_DEFER accordingly.
   And that's all what my patch does.

> We're not going through the same farce that the smsc network driver has
> gone through: OMAP3430LDP remains fucked through that idiotic ill-thought
> out change (c7e963f68888, net/smsc911x: Add regulator support).  See
> http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=99

If the understanding above is correct, I do not see how my patch would
bring the same farce into amba driver.

-- 
Regards,
Shawn
