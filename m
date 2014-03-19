From: fthain@telegraphics.com.au (Finn Thain)
Date: Wed, 19 Mar 2014 12:46:16 +1100 (EST)
Subject: [PATCH 00/12] scsi/NCR5380: fix debugging macros and #include
 structure
In-Reply-To: <1395190072.8649.2.camel@joe-AO722>
References: <20140318002822.372705594@telegraphics.com.au>
 <1395112756.20860.1.camel@joe-AO722>
 <alpine.LNX.2.00.1403182208590.2018@nippy.intranet>
 <1395146702.2812.47.camel@joe-AO722>
 <CAMuHMdUMpdp7deL5zC4hUVTHjyNbtkZ2bNFupo5JiDyuyc345w@mail.gmail.com>
 <1395148051.2812.51.camel@joe-AO722>
 <alpine.LNX.2.00.1403190925550.6652@nippy.intranet>
 <1395190072.8649.2.camel@joe-AO722>
Message-ID: <alpine.LNX.2.00.1403191240001.23002@nippy.intranet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tue, 18 Mar 2014, Joe Perches wrote:

> But using "if (0)" prevents the no_printk from occurring at all so there 
> would be no side-effects and the format & args would still be verified 
> by the compiler.

I'd prefer this (for symmetry and clarity):

#if NDEBUG
#define dprintk(flg, fmt, ...) \
        do { if ((NDEBUG) & (flg)) pr_debug(fmt, ## __VA_ARGS__); } while (0)
#else
#define dprintk(flg, fmt, ...) \
        do { if (0) pr_debug(fmt, ## __VA_ARGS__); } while (0)
#endif

But you seem to be asking for this instead:

#if NDEBUG
#define dprintk(flg, fmt, ...) \
        do { if ((NDEBUG) & (flg)) pr_debug(fmt, ## __VA_ARGS__); } while (0)
#else
#define dprintk(flg, fmt, ...) \
        do { if (0) no_printk(fmt, ## __VA_ARGS__); } while (0)
#endif

Why is that better?

-- 
