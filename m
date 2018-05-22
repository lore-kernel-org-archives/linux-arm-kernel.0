From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 May 2018 00:25:20 +0100
Subject: [PATCH 08/14] ARM: spectre-v2: harden user aborts in kernel space
In-Reply-To: <e52b3541-7106-a6dc-5851-01b091bec38f@arm.com>
References: <20180521114238.GN17671@n2100.armlinux.org.uk>
 <E1fKjFO-000648-8d@rmk-PC.armlinux.org.uk>
 <e52b3541-7106-a6dc-5851-01b091bec38f@arm.com>
Message-ID: <20180522232519.GV17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 06:15:02PM +0100, Marc Zyngier wrote:
> On 21/05/18 12:45, Russell King wrote:
> > +	switch (read_cpuid_part()) {
> > +	case ARM_CPU_PART_CORTEX_A8:
> > +	case ARM_CPU_PART_CORTEX_A9:
> > +	case ARM_CPU_PART_CORTEX_A12:
> > +	case ARM_CPU_PART_CORTEX_A17:
> > +	case ARM_CPU_PART_CORTEX_A73:
> > +	case ARM_CPU_PART_CORTEX_A75:
> > +		harden_branch_predictor = harden_branch_predictor_bpiall;
> > +		spectre_v2_method = "BPIALL";
> > +		break;
> 
> You don't seem to take into account the PFR0.CSV2 field which indicates
> that the CPU has a branch predictor that is immune to Spectre-v2.

That information is not covered in the description of the vulnerability
- the published information on the security-updates site states that
BPIALL is required without stating any conditions.

> See for example the Cortex-A75 r3p0 TRM[1].

So which cores should such a test be applied to?  As I mention,
the support site doesn't give this detail.  That brings up the
obvious question: what else does the web page miss out on?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
