From: schindele@nentec.de (Juergen Schindele)
Date: Thu, 26 Nov 2009 16:43:07 +0200
Subject: IXP425: help on HSS channelized service
In-Reply-To: <m3d437bi7i.fsf@intrepid.localdomain>
References: <4B0BDFC1.7010506@kaskonetworks.it>
	<m3d437bi7i.fsf@intrepid.localdomain>
Message-ID: <200911261543.08448.schindele@nentec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 25. November 2009 schrieb Krzysztof Halasa:
> The buffers have different structures for RX and TX.
This was a very good hint :-). I discovered that the 
"struct desc" used in the kernel mainline driver is quite 
different from the one used in INTEL code !?????.
When I replace the "struct desc" (see below) it works fine for me.
Isn't there a general problem with this driver when it works only 
for channelized mode (your case) ???
Has sombody made it working in HDLC_PIPE mode ????

here my changes:
I replaced 

struct desc {
        u32 next;               /* pointer to next buffer, unused */

#ifdef __ARMEB__
        u16 buf_len;            /* buffer length */
        u16 pkt_len;            /* packet length */
        u32 data;               /* pointer to data buffer in RAM */
        u8 status;
        u8 error_count;
        u16 __reserved;
#else
        u16 pkt_len;            /* packet length */
        u16 buf_len;            /* buffer length */
        u32 data;               /* pointer to data buffer in RAM */
        u16 __reserved;
        u8 error_count;
        u8 status;
#endif
        u32 __reserved1[4];
}

with 

struct desc {
#ifdef __ARMEB__
    u8   status;                /* status of packet desriptor */
    u8   error_count;           /* number of errors */
    u8   chain_count;           /* used for chained buffers otherwise 0 */
    u8   __reserved1;           /* reserved byte for word alignment */

    u16  pkt_len;               /* packet length payload */
    u16  __reserved2;           /* reserved short for word alignment */

    u32  head;                  /* pointer to first if chained buffers */
    u32  next;                  /* pointer to next if chained buffers */
    u32  data;                  /* pointer to data buffer in RAM */
    u32  buf_len;               /* total length of buffer in RAM */
#else
    u8   __reserved1;           /* reserved byte for word alignment */
    u8   chain_count;           /* used for chained buffers otherwise 0 */
    u8   error_count;           /* number of errors */
    u8   status;                /* status of packet desriptor */

    u16  __reserved2;           /* reserved short for word alignment */
    u16  pkt_len;               /* packet length payload */

    u32  head;                  /* pointer to first if chained buffers */
    u32  next;                  /* pointer to next if chained buffers */
    u32  data;                  /* pointer to data buffer in RAM */
    u32  buf_len;               /* total length of buffer in RAM */
#endif
    u32  __reserved3[2];        /* reserved to fill up */
}
 
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
