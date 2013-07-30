From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Tue, 30 Jul 2013 18:19:08 -0400
Subject: Defining schemas for Device Tree
In-Reply-To: <20130730205716.GZ9858@sirena.org.uk>
References: <2469263.vMN09Q7Tzi@flatron> <51F6E30B.7060106@wwwdotorg.org>
 <CAKON4Oy6+7ZpAG5emAm_c62t=o_LXM7PcbK-z5YL_qx=r0AKqQ@mail.gmail.com>
 <1706112.Xn49tiCSKF@thinkpad>
 <CAKON4OwNrhmvnznyeD-igtZ5nsm7atUZoa0RJttN5kmwKubaDg@mail.gmail.com>
 <20130730102511.GM9858@sirena.org.uk>
 <CAKON4OxSr13VPJkwkvuF91BwFXfQ6fkAuVeEsiA=JK3cuzmavQ@mail.gmail.com>
 <51F7F596.6020503@wwwdotorg.org>
 <CAKON4OykPqYA8+ZGxjiX00Ut+iM9hqiXr5D9KEZF3PVxoqiM1g@mail.gmail.com>
 <20130730205716.GZ9858@sirena.org.uk>
Message-ID: <CAKON4Ox7-6Jf0ce64Wqr5E49KS+9E135mqc_iG-PWQ7r8bzWHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 4:57 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 30, 2013 at 01:29:56PM -0400, jonsmirl at gmail.com wrote:
>> On Tue, Jul 30, 2013 at 1:19 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> > On 07/30/2013 07:14 AM, jonsmirl at gmail.com wrote:
>
>> > > Is something similar to this possible in device tree syntax?
>> > > dmas =  <"tx" &pdma0 7>,  <"rx"  &pdma0 6>;
>
>> > I /think/ you can physically write that in *.dts, or something very
>> > similar; with the strings outside the <>:
>
>> > dmas = "tx", <&pdma0 7>, "rx", <&pdma0 6>;
>
>> Can we turn the strings into string phandles? Then they'd be fixed sized.
>
>> That might provide a way to internationalize the strings too.
>
> I don't know how viable or sane this actually is but one suggestion I
> just made elsewhere which might help is to fix this at the dtc level by
> having syntatic sugar which will do the parallel arrays trick that
> people are currently using to write things out.  The user writes one
> array with multiple types of data in it and the actual output is two or
> more matched arrays each with a single type of data.
>
> It would help legibility and wouldn't impact the parsers.

FDT is versioned and PowerPC docs say that multiple versions have been
released.  If we find enough flaws we could do a new release then use
the quirks scheme to read the older versions.

So far the only issue I know of is that all of the strings aren't
stored in the string table. If all of the strings were in the string
table then we wouldn't have this variable attribute size problem.

8.2 Header
The layout of the header for the device tree is defined by the
following C structure. All the header
fields are 32-bit integers, stored in big-endian format.
struct fdt_header {
uint32_t magic;
uint32_t totalsize;
uint32_t off_dt_struct;
uint32_t off_dt_strings;
uint32_t off_mem_rsvmap;
uint32_t version;
uint32_t last_comp_version;
uint32_t boot_cpuid_phys;
uint32_t size_dt_strings;
uint32_t size_dt_struct;
};
?
magic
This field shall contain the value 0xd00dfeed (big-endian).
?
totalsize
This field shall contain the total size of the device tree data
structure. This size shall
encompass all sections of the structure: the header, the memory
reservation block, structure
block and strings block, as well as any free space gaps between the
blocks or after the final
block.
?
off_dt_struct
This field shall contain the offset in bytes of the structure block
(see 8.4) from the beginning
of the header.
?
off_dt_strings
This field shall contain the offset in bytes of the strings block (see
8.5) from the beginning of
the header.
?
off_mem_rsvmap
This field shall contain the offset in bytes of the memory reservation
block (see 8.3) from the
beginning of the header.
?
version
This field shall contain the version of the device tree data
structure. The version is 17 if using
the structure as defined in this document. An ePAPR boot program may
provide the device
tree of a later version, in which case this field shall contain the
version number defined in
whichever later document gives the details of that version.
?
last_comp_version
This field shall contain the lowest version of the device tree data
structure with which the
version used is backwards compatible. So, for the structure as defined
in this document
(version 17), this field shall contain 16 because version 17 is
backwards compatible with
version 16, but not earlier versions. As per 8.1, an ePAPR boot
program should provide a
device tree in a format which is backwards compatible with version 16,
and thus this field
shall always contain 16.
?
boot_cpuid_phys
This field shall contain the physical ID of the system?s boot CPU. It
shall be identical to the
physical ID given in the reg property of that CPU node within the device tree.
?
size_dt_strings
This field shall contain the length in bytes of the strings block
section of the device tree blob.
?
size_dt_struct
This field shall contain the length in bytes of the structure block
section of the device tree
blob.

-- 
Jon Smirl
jonsmirl at gmail.com
