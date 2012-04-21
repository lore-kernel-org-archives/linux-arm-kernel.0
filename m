From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 21 Apr 2012 18:37:34 +0000
Subject: [PATCH 1/9] SPEAr13xx: Add header files
In-Reply-To: <CAOh2x=ncefojSYBPUVgL1EKcQ+wPFzfCmo+TZ+3BEmwD+=Q=Gg@mail.gmail.com>
References: <cover.1334942163.git.viresh.kumar@st.com>
 <201204201752.05657.arnd@arndb.de>
 <CAOh2x=ncefojSYBPUVgL1EKcQ+wPFzfCmo+TZ+3BEmwD+=Q=Gg@mail.gmail.com>
Message-ID: <201204211837.35023.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 April 2012, viresh kumar wrote:
> On 4/20/12, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 20 April 2012, Viresh Kumar wrote:
> >> +/* RAS Area Control Register */
> >> +#define SPEAR1310_RAS_CTRL_REG0			(VA_SPEAR1310_RAS_BASE + 0x000)
> >> +	#define SPEAR1310_GPT64_SYNC_ENB		0
> >> +	#define SPEAR1310_GPT64_SYNC_ENB_MASK		1
> >> +	#define SPEAR1310_GPT64_SYNC_ENB_SHIFT		31
> >> +	#define SPEAR1310_SSP1_CS_SEL_CS0		0
> >> +	#define SPEAR1310_SSP1_CS_SEL_CS1		1
> >> +	#define SPEAR1310_SSP1_CS_SEL_MASK		3
> >> +	#define SPEAR1310_SSP1_CS_SEL_SHIFT		30
> >> +	#define SPEAR1310_SSP1_CS_VAL_MASK		1
> >> +	#define SPEAR1310_SSP1_CS_VAL_SHIFT		28
> >> +	#define SPEAR1310_SSP1_CS_CTL_HW		0
> >> +	#define SPEAR1310_SSP1_CS_CTL_SW		1
> >
> > Why are the RAS control registers in a global header? It looks like you
> > only use them from the clock driver, so they can be moved into a local
> > header file there.
> 
> Actually registers serves many different features. Clock, software controlled
> chip selects for spi, etc. So really can't move to clock drivers.
> 
> I didn't wanted half part of a register in one file and other half in other.
> So kept them here, so that these are accessible from all users.

It's still really ugly to have that in a global header file, including the
hardcoded register addresses.

What I'd suggest you do instead here is export a function to access the
registers from device drivers and add a new header file that contains
only this interface, the register offsets and the register definitions.
Then you can use proper of_iomap calls to get the area from the device
tree in the machine init code and it will be clear which drivers use the
interface because they have to explicitly include that header.

	Arnd
