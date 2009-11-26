From: schindele@nentec.de (Juergen Schindele)
Date: Thu, 26 Nov 2009 17:44:50 +0200
Subject: IXP425: help on HSS channelized service
In-Reply-To: <20091126144956.GA7150@n2100.arm.linux.org.uk>
References: <4B0BDFC1.7010506@kaskonetworks.it>
	<200911261543.08448.schindele@nentec.de>
	<20091126144956.GA7150@n2100.arm.linux.org.uk>
Message-ID: <200911261644.51155.schindele@nentec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 26. November 2009 schrieb Russell King - ARM Linux:
> On Thu, Nov 26, 2009 at 04:43:07PM +0200, Juergen Schindele wrote:
> > Am Mittwoch, 25. November 2009 schrieb Krzysztof Halasa:
> > > The buffers have different structures for RX and TX.
> > This was a very good hint :-). I discovered that the 
> > "struct desc" used in the kernel mainline driver is quite 
> > different from the one used in INTEL code !?????.
> > When I replace the "struct desc" (see below) it works fine for me.
> > Isn't there a general problem with this driver when it works only 
> > for channelized mode (your case) ???
> > Has sombody made it working in HDLC_PIPE mode ????
> > 
> > here my changes:
> > I replaced 
> > 
> > struct desc {
> >         u32 next;               /* pointer to next buffer, unused */
> > 
> > #ifdef __ARMEB__
> >         u16 buf_len;            /* buffer length */
> >         u16 pkt_len;            /* packet length */
> >         u32 data;               /* pointer to data buffer in RAM */
> >         u8 status;
> >         u8 error_count;
> >         u16 __reserved;
> > #else
> >         u16 pkt_len;            /* packet length */
> >         u16 buf_len;            /* buffer length */
> >         u32 data;               /* pointer to data buffer in RAM */
> >         u16 __reserved;
> >         u8 error_count;
> >         u8 status;
> > #endif
> >         u32 __reserved1[4];
> 
> If these structures are sensitive to the byte-endian, they should be
> defined using [bl]e(32|16|8) so that sparse can check that you're
> using appropriate cpu_to_xxx() and xxx_to_cpu() endian conversions on
> them.
Thanks for your information. I can include "linux/types.h"
where are defined these typedefs (i think its what you mean):

typedef __u16 __bitwise __le16;
typedef __u16 __bitwise __be16;
typedef __u32 __bitwise __le32;
typedef __u32 __bitwise __be32;

but where are these ????
typedef __u8 __bitwise __le8;
typedef __u8 __bitwise __be8;

are they missing or am _I_ missing something ??? 

--------------------------------------------------------------
J?rgen Schindele  
Software-Entwicklung

NENTEC Netzwerktechnologie GmbH
Greschbachstr. 12
76229 Karlsruhe
Deutschland
Telefon: +49 721 94249-51
Telefax: +49 721 94249-10
E-Mail:  schindele at nentec.de
WEB:     www.nentec.de
 
Gesch?ftsf?hrung: Klaus Becker, Roland Knapp
Sitz der Gesellschaft: Karlsruhe
Handelsregister: Amtsgericht Mannheim HRB 107658
--------------------------------------------------------------
