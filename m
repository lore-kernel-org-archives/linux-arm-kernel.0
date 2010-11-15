From: bpringle@sympatico.ca (Bill Pringlemeir)
Date: Mon, 15 Nov 2010 13:17:17 -0500
Subject: [Patch v3] Fix audmuxv2 debugfs indexing.
In-Reply-To: <20101115162636.GH12986@rakim.wolfsonmicro.main> (Mark Brown's
	message of "Mon, 15 Nov 2010 16:26:36 +0000")
References: <BLU0-SMTP14C9A6CEFEB68711495B30B8300@phx.gbl>
	<20101110152619.GB8950@pengutronix.de>
	<BLU0-SMTP84DA72E534B9B3F1DCEA5BB8320@phx.gbl>
	<20101112071706.GF6017@pengutronix.de>
	<20101112114942.GA28804@sirena.org.uk> <87oc9rk6fe.fsf@sympatico.ca>
	<BLU0-SMTP271B3B53A7BF23C621F315B8360@phx.gbl>
	<20101115153058.GG12986@rakim.wolfsonmicro.main>
	<87oc9qeg75.fsf@sympatico.ca>
	<BLU0-SMTP55EFC1F097F339783A2A30B8360@phx.gbl>
	<20101115162636.GH12986@rakim.wolfsonmicro.main>
Message-ID: <BLU0-SMTP34594F9F26E8EBD100C9CAB8360@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 Nov 2010, broonie at opensource.wolfsonmicro.com wrote:
On Mon, Nov 15, 2010 at 11:10:31AM -0500, Bill Pringlemeir wrote:

>> Sorry, I should have waited to email.  audmux_port_string() only
>> handles six values (not seven).  Also, the audmux.h only has six
>> defines for both MX31 and MX27.  There isn't an SSI7 that is being
>> reported by the debugfs.  However, a user of the audmux-v2.c code can
>> call mxc_audmux_v2_configure_port() with a port value of '6' to
>> configure audmux pin set 7 ;-)

> SSI7 is an internal network connection thing of some kind.

On pg 4-60 of the IMX 25 reference manual, the IOMUX configuration for
ALT3 is AUD7_TXFS.  This makes me think it is a 'physical' pin after
the IOMUX routing.

 $ grep AUD7 arch/arm/plat-mxc/include/mach/iomux-mx25.h
    364:#define MX25_PAD_SD1_DATA1__AUD7_RXD  
    469:#define MX25_PAD_GPIO_E__AUD7_TXD     
    472:#define MX25_PAD_GPIO_F__AUD7_TXC     
    481:#define MX25_PAD_VSTBY_REQ__AUD7_TXFS 
    487:#define MX25_PAD_POWER_FAIL__AUD7_RXD 

Oddly, the iomux-mx25.h is the only 'iomux-mx[1235]*.h' one with this
audmux 7 configuration, but some of the ALT configuration values are
missing from these files.  Maybe the MX25 is different.  It is the
only IMX processor that I am familar with.

'iomux-mx25.h' has

     77:#define MX25_PAD_EB0__AUD4_TXD         
     81:#define MX25_PAD_EB1__AUD4_RXD         
     85:#define MX25_PAD_OE__AUD4_TXC          
    117:#define MX25_PAD_RW__AUD4_TXFS         
    364:#define MX25_PAD_SD1_DATA1__AUD7_RXD   
    394:#define MX25_PAD_KPP_COL0__AUD5_TXD    
    399:#define MX25_PAD_KPP_COL1__AUD5_RXD    
    404:#define MX25_PAD_KPP_COL2__AUD5_TXC    
    409:#define MX25_PAD_KPP_COL3__AUD5_TXFS   
    413:#define MX25_PAD_FEC_MDC__AUD4_TXD     
    417:#define MX25_PAD_FEC_MDIO__AUD4_RXD    
    424:#define MX25_PAD_FEC_TDATA1__AUD4_TXFS 
    469:#define MX25_PAD_GPIO_E__AUD7_TXD      
    472:#define MX25_PAD_GPIO_F__AUD7_TXC      
    481:#define MX25_PAD_VSTBY_REQ__AUD7_TXFS  
    487:#define MX25_PAD_POWER_FAIL__AUD7_RXD  

As well, chapter 4 (IOMUX) of the IMX25 RM has,

  LD8, ALT4  -> AUD3_TXD
  LD9, ALT4  -> AUD3_RXD
  LD10, ALT4 -> AUD3_TXC
  LD11, ALT4 -> AUD3_TXFS
  LD14, ALT6 -> AUD3_RXC
  LD15, ALT6 -> AUD3_RXFS

  CSID8, ALT2 -> AUD6_RXC
... etc.

>> The documentation we are working with isn't that helpful.  For the iMx
>> 25 pg 13-4, it says there are "Three internal ports", but I can only
>> find two ssi devices (with two channels of audio each)...

> It's not an SSI port.

No, I don't think it is an SSI protocol device either.  I think there
are two internal ports and five external ports, at least on the IMX
25.  Maybe the documentation is cut and paste from another processor?

There is this cryptic section of the on pg 13-4,

   13.2      External Signal Description

   Table 13-2 lists AUDMUX pin-level signals for the external ports,
   where:

      ? Pn is P4, through P7
      ? m = n ? 3.

   The port is configured as an external port by a static system-level
   signal input pn_int_ext_select.

I guess they could be 'internal' if you didn't configure an external
pin with the iomux module.  Register
IOMUXC_AUDMUX_P4_INPUT_DA_AMX_SELECT_INPUT (offset 0x460) might be
what the above section refers to, but this involves 'daisy chaining'
and only AUDMUX_P4 and AUDMUX_P7 are listed here (No P3,P5,P6).

Thanks for you help.  I *think* I am getting closer to understanding
this now.

Regards,
Bill Pringlemeir.

-- 
Someday we'll look back on all this and plow into a parked car.
