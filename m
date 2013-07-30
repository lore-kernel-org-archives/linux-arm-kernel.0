From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Tue, 30 Jul 2013 19:23:36 -0400
Subject: Defining schemas for Device Tree
In-Reply-To: <20130730230331.GC9858@sirena.org.uk>
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
Message-ID: <CAKON4OzFdZhX0Kzu_6KiimD=KxDr6EM13zUH3GGE=hHaYx=m=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 7:03 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 30, 2013 at 06:19:08PM -0400, jonsmirl at gmail.com wrote:
>
>> FDT is versioned and PowerPC docs say that multiple versions have been
>> released.  If we find enough flaws we could do a new release then use
>> the quirks scheme to read the older versions.
>
> That does involve updating everything that wants to understand FDTs in
> the new FDT format version though.  I'm not sure that's going to be
> greeted with universal enthusiasm.

Shipped hardware containing FDTs would keep the version they shipped
with. That's the point of making this  a stable ABI. The Linux quirk
code would convert the older format to the new format at boot time.

So to change this you need to:
1) change dtc to produce the new version
2) adjust the kernel code to understand the new version
3) adjust the quirk code to convert the known set of older firmware
based FDTs into the new format. For the simple string case the strings
would be turned into indirect pointers instead of being in-line.

The only way you could get in trouble would be by upgrading an old
firmware FDT to the new format and then booting an old Linux or
another OS. But this is a general problem not specific to the FDT
versioning - if you replace the firmware FDT with one of the later
Linux ones that has been rewritten, the older stuff isn't going to
boot either since it won't understand the changes.  Simple answer - if
you are going to boot other OSes or old Linux kernels, don't mess with
the firmware FDT that the device shipped with, leave it alone.

Uboot could be an issue but I don't think they are actually doing
anything with FDTs yet, they are just talking about doing it.


-- 
Jon Smirl
jonsmirl at gmail.com
