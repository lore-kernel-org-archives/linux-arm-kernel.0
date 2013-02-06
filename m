From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 6 Feb 2013 16:15:57 +0200
Subject: [PATCH] OMAPDSS: enable omapdss for ARCH_MULTIPLATFORM
In-Reply-To: <201302051631.40254.arnd@arndb.de>
References: <1358891160-9534-1-git-send-email-robdclark@gmail.com>
 <201301222153.19580.arnd@arndb.de> <201302051631.40254.arnd@arndb.de>
Message-ID: <5112659D.50808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Rob,

On 2013-02-05 18:31, Arnd Bergmann wrote:
> On Tuesday 22 January 2013, Arnd Bergmann wrote:
>> On Tuesday 22 January 2013, Rob Clark wrote:
>>> At least core omapdss does not have any build dependencies on
>>> ARCH_OMAP2PLUS, and adding this dependency in the Kconfig breaks omapdrm
>>> for ARCH_MULTIPLATFORM builds.
>>>
>>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> It seems nobody has applied this patch, as it has not shown up in
> linux-next or upstream. Who should take care of this? If nobody feels
> responsible, I can put it into arm-soc/fixes.

That would normally be me, but I've been on a long leave, and just came
back. It'll take me some time to get back on track.

I don't think it makes sense to add ARCH_MULTIPLATFORM only for omapdss,
like this patch does. I think we should add it for omapfb and the panel
drivers also.

I did get a report of an omapdss build-break with allyesconfig. It seems
to happen because omapdrm and omap_vout use "select" to enable omapdss,
instead of depending on omapdss. This causes an illegal config to be
created. Perhaps this is the problem that Rob mentions in his patch?

Adding ARCH_MULTIPLATFORM for omapdss, as this patch does, removes
(well, hides) the above mentioned problem and allyesconfig works ok. You
can still break the config, but you need to manually select the Kconfig
options the wrong way.

I have patches to add the ARCH_MULTIPLATFORM for omapdss, and to fix the
omap_vout and omapdrm Kconfig files. Each of them changes only one line.
Arnd, are you ok with queuing those patches via arm-soc/fixes? Or should
I send them individually to respective maintainers?

I can send the patches properly for review, but I've also attached them
here so Rob can test.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-OMAPDSS-add-support-for-ARCH_MULTIPLATFORM.patch
Type: text/x-patch
Size: 1019 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130206/6eef4ee4/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-omap_vout-fix-the-dependency-on-OMAPDSS.patch
Type: text/x-patch
Size: 1211 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130206/6eef4ee4/attachment-0001.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-omapdrm-fix-the-dependency-on-OMAPDSS.patch
Type: text/x-patch
Size: 1097 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130206/6eef4ee4/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130206/6eef4ee4/attachment.sig>
