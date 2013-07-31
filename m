From: tony@atomide.com (Tony Lindgren)
Date: Wed, 31 Jul 2013 00:01:09 -0700
Subject: Defining schemas for Device Tree
In-Reply-To: <CAKON4OwY3xh3UGjTxb4ypkcmrTpVYO-FZovq-ierabYMf4CDQA@mail.gmail.com>
References: <CAKON4OxSr13VPJkwkvuF91BwFXfQ6fkAuVeEsiA=JK3cuzmavQ@mail.gmail.com>
 <51F7F596.6020503@wwwdotorg.org>
 <CAKON4OykPqYA8+ZGxjiX00Ut+iM9hqiXr5D9KEZF3PVxoqiM1g@mail.gmail.com>
 <51F7F914.6040709@wwwdotorg.org>
 <CAKON4Oy6hL9LzHdfq4vWcurbw6TU3HCK_jq14xwweA8dvOGtdw@mail.gmail.com>
 <51F7FCA6.6010909@wwwdotorg.org>
 <CAKON4OzLgC-ahDhLnbYEYrSj7dbFRU0z7Do_D32XNqux2UhvXw@mail.gmail.com>
 <CAKON4OyMfNUR=NGn+OEvN3utcEzRfG6A4rPO6+h5Q4mq_tmoxw@mail.gmail.com>
 <51F80526.1020201@wwwdotorg.org>
 <CAKON4OwY3xh3UGjTxb4ypkcmrTpVYO-FZovq-ierabYMf4CDQA@mail.gmail.com>
Message-ID: <20130731070108.GS7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* jonsmirl at gmail.com <jonsmirl@gmail.com> [130730 11:36]:
> On Tue, Jul 30, 2013 at 2:25 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> > On 07/30/2013 12:04 PM, jonsmirl at gmail.com wrote:
> > ...
> >> So what does an alternating use of strings do?
> >>
> >>  dmas = "tx", <&pdma0 7>, "rx", <&pdma0 6>;
> >
> > cat > temp.dts << ENDOFHERE
> > /dts-v1/;
> >
> > / {
> >     dmas = "tx", <&pdma0 7>, "rx", <&pdma0 6>;
> >
> >     pdma0: dma { };
> > };
> > ENDOFHERE
> >
> > dtc -O dtb -o temp.dtb -I dts temp.dts
> >
> > hexdump -C temp.dtb
> >
> > yields:
> >
> >> 00000000  d0 0d fe ed 00 00 00 ab  00 00 00 38 00 00 00 98  |...........8....|
> >> 00000010  00 00 00 28 00 00 00 11  00 00 00 10 00 00 00 00  |...(............|
> >> 00000020  00 00 00 13 00 00 00 60  00 00 00 00 00 00 00 00  |.......`........|
> >> 00000030  00 00 00 00 00 00 00 00  00 00 00 01 00 00 00 00  |................|
> >> 00000040  00 00 00 03 00 00 00 16  00 00 00 00 74 78 00 00  |............tx..|
> >                                                  ss ss ss pp
> >> 00000050  00 00 01 00 00 00 07 72  78 00 00 00 00 01 00 00  |.......rx.......|
> >             pp pp pp ii ii ii ii ss  ss ss pp pp pp pp ii ii
> >> 00000060  00 06 00 00 00 00 00 01  64 6d 61 00 00 00 00 03  |........dma.....|
> >             ii ii
> >
> > ... where ss represents a string byte, pp a phandle byte, ii an integer
> > byte.
> >
> >> 00000070  00 00 00 04 00 00 00 05  00 00 00 01 00 00 00 03  |................|
> >> 00000080  00 00 00 04 00 00 00 0b  00 00 00 01 00 00 00 02  |................|
> >> 00000090  00 00 00 02 00 00 00 09  64 6d 61 73 00 6c 69 6e  |........dmas.lin|
> >> 000000a0  75 78 2c 70 68 61 6e 64  6c 65 00                 |ux,phandle.|
> >
> > Starting about half way through that last line is the string table.
> >
> > (the string table indirection is for property names, not property
> > values, and it looks like not for node names either)
> 
> Ok, so this won't work without introducing variable length data. Too
> bad, I would have liked to eliminate the paired attributes.

Yup that's my experience too. But then again, using string values
in .dts should not be done in general as it bloats things and makes
the parsing slow.

These kind of names for something is usually something that should
be implemented as user space debug tools, and the kernel really does
not need to know names for something coming from DT.

Of course without using string names there's the issue how to know
what is rx dma and what is tx dma in the binding :) Probably what
we've done with interrupt numbers is the way to go with DT to avoid
string names.

Regards,

Tony
