From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 7 Feb 2013 13:40:32 +0200
Subject: [PATCH] OMAPDSS: enable omapdss for ARCH_MULTIPLATFORM
In-Reply-To: <3969096.QosOfOb9QT@wuerfel>
References: <1358891160-9534-1-git-send-email-robdclark@gmail.com>
 <201302051631.40254.arnd@arndb.de> <5112659D.50808@ti.com>
 <3969096.QosOfOb9QT@wuerfel>
Message-ID: <511392B0.4040409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-02-06 16:29, Arnd Bergmann wrote:
> On Wednesday 06 February 2013 16:15:57 Tomi Valkeinen wrote:

>> I have patches to add the ARCH_MULTIPLATFORM for omapdss, and to fix the
>> omap_vout and omapdrm Kconfig files. Each of them changes only one line.
>> Arnd, are you ok with queuing those patches via arm-soc/fixes? Or should
>> I send them individually to respective maintainers?
>>
>> I can send the patches properly for review, but I've also attached them
>> here so Rob can test.
> 
> The second and third attachment in your mail seem to contain identical
> patches. I suggested a similar patch myself, but Rob thought his

Hmm? They look different to me...
0002-omap_vout-fix-the-dependency-on-OMAPDSS.patch fixes the dependency
for omap_vout, 0003-omapdrm-fix-the-dependency-on-OMAPDSS.patch for omapdrm.

> version was nicer to give better build coverage. We only need either
> Rob's patch or yours, but not both, as far as I can tell.

I read the related posts, but I'm a bit confused here. Let me summarize
what has happened and what are the issues:

I changed omapdss, omapfb and omap panel drivers to be platform
independent, and after that they compiled fine on OMAP and x86, and
should compile fine on any other platform as well. I thus removed the
Kconfig build dependencies for OMAP. This is what I sent for 3.8 merge
window.

However, Linus complained that now he's getting asked if he wants to
enable omapdss driver when he's building x86 kernel. So Tony made a
patch that added the ARCH_OMAP2PLUS dependency to omapdss (and some
other omap drivers), which went in.

Now, if I'm not mistaken, Rob then added possibility to build omapdrm on
ARCH_MULTIPLATFORM. No problem with that as such, but omapdrm's Kconfig
uses select to enable omapdss, which does not work. omapdss was not made
to work with others using "select" to enable it, but one should "depend
on" to it.

This caused omapdss to be enabled partially when omapdrm is enabled on
ARCH_MULTIPLATFORM, causing build failure.

So the real fix to the issue is the 0003 patch, which changes omapdrm to
use "depend on", not "select". However, adding only that patch will
prevent omapdrm to be built on ARCH_MULTIPLATFORM, as omapdss is not
enabled on ARCH_MULTIPLATFORM. That one can be enabled with the 0001 patch.

Adding only 0001 patch will also "fix" the build issue, as then omapdss
is properly enabled on allyesconfig ARCH_MULTIPLATFORM build, even if
omapdrm erroneously uses select to enable omapdss. However, adding only
0001 will still allow the user to manually break the build by disabling
omapdss (I think, I didn't test that).

The difference between my 0001 patch and Rob's patch is that Rob only
enables omapdss to be built on ARCH_MULTIPLATFORM, leaving omapfb and
omap panel drivers out. Leaving omapfb is not an issue, but if the panel
drivers are left out, I don't see how omapdrm can function properly,
even if compilation works fine.

> Olof can correct me, but I think we currently don't have any other
> patches queued in arm-soc for 3.8 (after Linus announced he did
> not want any of the less urgent ones), so I think it would be more
> fitting if you send one of the patches to Linus, rather than having
> an arm-soc pull request that only contains one patch in your domain.

Ok, I'll do that. I'm still not sure if I should send only the 0001
patch, or all three. I guess I'll go for all three if nobody objects.

Rob, can you test the patches so we're sure they do what they are
supposed to?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130207/6de2fb3e/attachment.sig>
