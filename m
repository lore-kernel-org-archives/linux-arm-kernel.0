From: broonie@kernel.org (Mark Brown)
Date: Thu, 22 May 2014 18:48:18 +0100
Subject: The resume of sgtl5000 causes kernel Oops
In-Reply-To: <20140522145650.GD32184@dragon>
References: <20140522145650.GD32184@dragon>
Message-ID: <20140522174818.GN12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 10:56:51PM +0800, Shawn Guo wrote:
> The suspend/resume test on imx51-babbage board discovers a kernel Oops
> caused by sgtl5000_resume().  I believe it happens due to commit
> e5d80e82e32e (ASoC: sgtl5000: Convert to use regmap directly).  After
> the commit, it seems that the codec->reg_cache in function
> sgtl5000_restore_regs() becomes invalid.  It looks that the register
> restoring in the function requires some strict sequence, I'm not sure
> what the correct fix is.

Yes, reg_cache isn't there if we're not using ASoC level caching.  The
fix should just be to replace the direct cache references with
snd_soc_read()s which will end up in a cache lookup if the register is
cached.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140522/6d4e05d8/attachment.sig>
