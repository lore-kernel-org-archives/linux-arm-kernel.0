From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 31 Jul 2013 14:47:12 -0600
Subject: Defining schemas for Device Tree
In-Reply-To: <CAKON4OzFdZhX0Kzu_6KiimD=KxDr6EM13zUH3GGE=hHaYx=m=Q@mail.gmail.com>
References: <51F6E30B.7060106@wwwdotorg.org>
 <CAKON4Oy6+7ZpAG5emAm_c62t=o_LXM7PcbK-z5YL_qx=r0AKqQ@mail.gmail.com>
 <1706112.Xn49tiCSKF@thinkpad>
 <CAKON4OwNrhmvnznyeD-igtZ5nsm7atUZoa0RJttN5kmwKubaDg@mail.gmail.com>
 <20130730102511.GM9858@sirena.org.uk>
 <CAKON4OxSr13VPJkwkvuF91BwFXfQ6fkAuVeEsiA=JK3cuzmavQ@mail.gmail.com>
 <51F7F596.6020503@wwwdotorg.org>
 <CAKON4OykPqYA8+ZGxjiX00Ut+iM9hqiXr5D9KEZF3PVxoqiM1g@mail.gmail.com>
 <20130730205716.GZ9858@sirena.org.uk>
 <CAKON4Ox7-6Jf0ce64Wqr5E49KS+9E135mqc_iG-PWQ7r8bzWHA@mail.gmail.com>
 <20130730230331.GC9858@sirena.org.uk>
 <CAKON4OzFdZhX0Kzu_6KiimD=KxDr6EM13zUH3GGE=hHaYx=m=Q@mail.gmail.com>
Message-ID: <51F977D0.7050200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2013 05:23 PM, jonsmirl at gmail.com wrote:
> On Tue, Jul 30, 2013 at 7:03 PM, Mark Brown <broonie@kernel.org> wrote:
>> On Tue, Jul 30, 2013 at 06:19:08PM -0400, jonsmirl at gmail.com wrote:
>>
>>> FDT is versioned and PowerPC docs say that multiple versions have been
>>> released.  If we find enough flaws we could do a new release then use
>>> the quirks scheme to read the older versions.
>>
>> That does involve updating everything that wants to understand FDTs in
>> the new FDT format version though.  I'm not sure that's going to be
>> greeted with universal enthusiasm.
> 
> Shipped hardware containing FDTs would keep the version they shipped
> with. That's the point of making this  a stable ABI. The Linux quirk
> code would convert the older format to the new format at boot time.
> 
> So to change this you need to:
> 1) change dtc to produce the new version
> 2) adjust the kernel code to understand the new version
> 3) adjust the quirk code to convert the known set of older firmware
> based FDTs into the new format. For the simple string case the strings
> would be turned into indirect pointers instead of being in-line.

There's one issue issue with the quirk/conversion layer in the kernel.

Various combinations are supposed to work:

1) The "current" kernel with the "current" DTB. I think everyone agrees
on that much:-)

2) Using an old DTB with a new kernel. This could be handled by having
stable DT bindings, and/or by having a quirk/conversion layer in the
kernel to convert old DTBs into whatever format the new kernel expects.

3) Using a new DTB with a old kernel. Rob Herring raised the point that
a firmware update (which might include updating the DTB the firmware
passes to the kernel) should not make the kernel you have installed in
the filesystem fail to boot.

I'm assuming that if the quirk/conversion layer you're championing were
the solution chosen for (2), then at least some of the time, people
would start using the new DT binding when writing new DTs, or modifying
existing DTs. That would break point (3) above, since the new DT would
no longer work with the old kernel.

I think the only way to satisfy all three points above is to have truly
stable backwards-compatible bindings, without relying on any in-kernel
conversion layer.
