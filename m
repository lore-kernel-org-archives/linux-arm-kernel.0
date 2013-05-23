From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 May 2013 23:44:11 +0200
Subject: [RFC 3/8] mfd:syscon: Introduce claim/read/write/release APIs
In-Reply-To: <519A1BBB.2070903@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <201305171636.49627.arnd@arndb.de> <519A1BBB.2070903@st.com>
Message-ID: <201305232344.11974.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 May 2013, Srinivas KANDAGATLA wrote:
> On 17/05/13 15:36, Arnd Bergmann wrote:
>
> Some of the drivers like Ethernet already provide higher level
> interfaces via callbacks. We did implement such a callbacks per each SOC
> in non-DT case, and ended up having code duplicated for each SOC.
> 
> On the other hand using device trees to describe the HW
> configuration(sysconfs) made more sense and got rid of SOC specific
> callbacks.

I'm sure it's possible to reduce the duplication without going all
the way to describing every bit in DT.

> > For drivers that are essentially just wrappers around sysconf,
> > I would make them one driver per SoC and use a low-level interface
> > but still hardcode the offsets in the driver instead of using DT
> > to find the registers.
> > 
> > The pinctrl and reset drivers are examples of this.
> 
> In pinctrl bindings case, I think we could do better job by replacing
> the existing bindings of sysconfs for a group of banks with just two
> integer offsets. This would mean that, we can still use the a common
> driver across the SOCs.
>
> And w.r.t to reset, we are planning on using sysconf based
> reset-controller API sitting underneath the reset-controller subsystem.
> Passing the information from device trees would be much clear and
> flexible than adding new driver per/SOC.

Ok

> >> 2> The infrastructure should protect the claimed registers from
> >> over-writing by other drivers. We do this by claim-read/write-release
> >> style API.
> > 
> > I don't understand this part. Is it about atomicity of accesses to
> > 32-bit registers when you only want to change a bit? That is something
> > the regmap interface handles already.
> 
> I forget to mention a important point here, the protection is at bit
> level for the sysconfs. Some of sysconfs have bits shared across IPs, so
> protecting them while the IP is still using it is what we are trying to
> achieve with sysconf-claim/release apis.
> While it may be overkill, but In past it has found bugs and been helpful
> with a meaning full debug output.

Can you give an example of something that is shared across multiple IPs?

Are those always done in the way that you have e.g. the ethernet pinctrl
in the same register as the usb pinctrl, or could you have an ethernet
pinctrl setting mixed together with the usb clock setting for instance?

If the hardware has been designed in a sensible way rather than just
grown by randomly adding bits in open spaces, I would assume that it's
possible to have high-level interfaces built around ranges of registers
rather than arbitrary subsets of registers.

	Arnd
