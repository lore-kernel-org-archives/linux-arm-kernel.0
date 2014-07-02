From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Jul 2014 19:54:22 +0100
Subject: [PATCH v7 8/9] ARM: vdso initialization, mapping, and
 synchronization
In-Reply-To: <CALCETrU-461E2ybeYcN7KFSPkwWtHikwCDo4t9T5Z5dCBGmNJA@mail.gmail.com>
References: <53B2C178.30607@mentor.com> <20140701141541.GP28164@arm.com>
 <CALCETrWeTeeuz4vW6wrhtDrdg54O-hhFbspfKEEunRZ0zf7ZBg@mail.gmail.com>
 <20140702144050.GD24879@arm.com>
 <CALCETrUVa-Yt7qZpzkpiAGVf+sYeasNq_YS1MuH6CFfWCcW6BA@mail.gmail.com>
 <53B430F3.9070804@mentor.com> <20140702162726.GG24879@arm.com>
 <CALCETrVSqH66jqG2_O2dir-3md4SHH800qs++4KhWYsGm9T-BQ@mail.gmail.com>
 <20140702172443.GI24879@arm.com>
 <CALCETrU-461E2ybeYcN7KFSPkwWtHikwCDo4t9T5Z5dCBGmNJA@mail.gmail.com>
Message-ID: <20140702185422.GP24879@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cheers for this, Andy.

On Wed, Jul 02, 2014 at 07:34:22PM +0100, Andy Lutomirski wrote:
> On Wed, Jul 2, 2014 at 10:24 AM, Will Deacon <will.deacon@arm.com> wrote:
> > ELF Header:
> >   Start of section headers:          1888 (bytes into file)
> >   Size of section headers:           64 (bytes)
> >   Number of section headers:         14
> 
> That's 896 bytes for the section table, starting at offset 1888.
> 
> >   Section header string table index: 13
> 
> 
> >
> > Section Headers:
> >   [13] .shstrtab         STRTAB           0000000000000000  000006e8
> >        0000000000000078  0000000000000000           0     0     1
> 
> 120 bytes of section headers strings, starting at offset 1768 (and not
> allocatable -- no 'A' here).
> 
> >
> > Program Headers:
> >   Type           Offset             VirtAddr           PhysAddr
> >                  FileSiz            MemSiz              Flags  Align
> >   LOAD           0x0000000000000000 0x0000000000000000 0x0000000000000000
> >                  0x00000000000006e8 0x00000000000006e8  R E    10
> 
> The loadable segment is 1768 bytes long, starting at the beginning of
> the file (and therefore the beginning of the mapping).
> 
> So you have a total of 1016 bytes of non-allocatable stuff at the end
> that I've accounted for.  I assume that the whole file is 2784 bytes.

Correct.

> If you added text or data to bring PT_LOAD to between 3081 and 4095
> bytes, then the section headers and/or section string table would
> cross a page boundary.

Ok, so that explains why things are working at the moment and it sounds like
we have some wiggle room too. I'll look at moving the datapage anyway, since
having these artificial limits is error-prone and fragile, but I don't think
it's something we need to panic about immediately.

Also, if you get to the bottom of your binutils issues with the section
allocation, that might work for us since we don't really have any legacy
binutils supporting arm64.

Will
