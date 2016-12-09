From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 9 Dec 2016 17:33:02 +0100
Subject: [PATCH 1/3] rtc: armada38x: improve RTC errata implementation
In-Reply-To: <8760mtf538.fsf@free-electrons.com>
References: <20161208171010.29446-1-gregory.clement@free-electrons.com>
 <20161208171010.29446-2-gregory.clement@free-electrons.com>
 <20161208172923.GQ26852@lunn.ch>
 <8760mtf538.fsf@free-electrons.com>
Message-ID: <20161209163302.GF9923@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2016 at 05:19:07PM +0100, Gregory CLEMENT wrote:
> Hi Andrew,
>  
>  On jeu., d?c. 08 2016, Andrew Lunn <andrew@lunn.ch> wrote:
> 
> >> +struct str_value_to_freq {
> >> +	unsigned long value;
> >> +	u8 freq;
> >> +} __packed;
> >> +
> >> +static unsigned long read_rtc_register_wa(struct armada38x_rtc *rtc, u8 rtc_reg)
> >> +{
> >> +	unsigned long value_array[SAMPLE_NR], i, j, value;
> >> +	unsigned long max = 0, index_max = SAMPLE_NR - 1;
> >> +	struct str_value_to_freq value_to_freq[SAMPLE_NR];
> >
> > Hi Gregory
> >
> > This appears to be putting over 900 bytes on the stack. Is there any
> 
> Actually the structure being packed it is 500 bytes.

Did you verify this? I never remember where the __packed needs to go.
You clearly have a packed structure, but is the array of structures
packed?

And the long value_array[SAMPLE_NR] is another 400 bytes, totalling
900. And as Russell pointed out, this is on 32 bit systems. Until your
third patch, 64 bit systems probably have double that. I would also
suggest squashing patch #3 into #1.

> > danger of overflowing the stack? Would it be safer to make these
> > arrays part of armada38x_rtc?
> 
> We could do this if you fear a stack overflow.

It is generally consider not a good idea to put > $BIG structures on
the stack, but the value of $BIG is not clearly defined. Stack
overflow seems to be an issue with lots of layering going on, swap on
NFS etc. But it seems unlikely to me reading the RTC will happen with
an already deep stack. So this is probably O.K.

   Andrew
