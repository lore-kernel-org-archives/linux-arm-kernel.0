From: kernel@martin.sperl.org (Martin Sperl)
Date: Wed, 17 Feb 2016 19:25:45 +0100
Subject: [PATCH V4 5/7] clk: bcm2835: add missing 22 HW-clocks.
In-Reply-To: <56B8782C.4060107@martin.sperl.org>
References: <1452867667-2447-1-git-send-email-kernel@martin.sperl.org>
 <1452867667-2447-6-git-send-email-kernel@martin.sperl.org>
 <87h9hr517u.fsf@eliezer.anholt.net> <56B8782C.4060107@martin.sperl.org>
Message-ID: <A977D3F2-1F64-41C8-B8ED-EB9F0B3554B9@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 08.02.2016, at 12:12, Martin Sperl <kernel@martin.sperl.org> wrote:
> 
> 
> 
> On 02.02.2016 02:51, Eric Anholt wrote:
>> kernel at martin.sperl.org writes:
>> 
>>> From: Martin Sperl <kernel@martin.sperl.org>
>>> 
>>> There were 22 HW clocks missing from the clock driver.
>>> 
>>> These have been included and int_bits and frac_bits
>>> have been set correctly based on information extracted
>>> from the broadcom videocore headers
>>> (http://www.broadcom.com/docs/support/videocore/Brcm_Android_ICS_Graphics_Stack.tar.gz)
>>> 
>>> For an extracted view of the registers please see:
>>> https://github.com/msperl/rpi-registers/blob/master/md/Region_CM.md
>>> 
>>> bcm2835_clock_per_parents has been assigned as the parent
>>> clock for all new clocks, but this may not be correct
>>> in all cases - documentation on this is not publicly
>>> available, so some modifications may be needed in the
>>> future.
>> 
>> We need the parents to be correct if we're going to land the patch.
>> I'll try to update them.
>> 
>> I'm not a fan of this "let's just shove everything we can find in some
>> header file into the .c and hope for the best."  Most of these clocks
>> were left out intentionally.
> 
> Well - I wanted to get them in just in case we need them later.
> 
> If you have got access to documentation which states the correct
> parent mux, then please share them so that we can implement them
> correctly.
> 
> Also listing all allows us then to expose the values of the registers
> via debugfs in case we need it - see separate RFC-patch 9 -  where
> we expose the raw register values as well.
> 
>>> +static const struct bcm2835_clock_data bcm2835_clock_aveo_data = {
>>> +	.name = "aveo",
>>> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
>>> +	.parents = bcm2835_clock_per_parents,
>>> +	.ctl_reg = CM_AVEOCTL,
>>> +	.div_reg = CM_AVEODIV,
>>> +	.int_bits = 4,
>>> +	.frac_bits = 12,
>>> +};
>> 
>> AVEO has 0 fractional bits
> 
> Correct - my issue (copy paste - I assume).
> 
>> 
>>> +static const struct bcm2835_clock_data bcm2835_clock_ccp2_data = {
>>> +	/* this is possibly a gate */
>>> +	.name = "ccp2",
>>> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
>>> +	.parents = bcm2835_clock_per_parents,
>>> +	.ctl_reg = CM_CCP2CTL,
>>> +	.div_reg = CM_CCP2DIV,
>>> +	.int_bits = 1,
>>> +	.frac_bits = 0,
>>> +};
>> 
>> CCP2 is a gate from a different clock source, so this won't work.
> See comment above: please provide parent clock mux.
> See also my comment about 3 clock that may be gates - this applies.
> 
>> 
>>> +static const struct bcm2835_clock_data bcm2835_clock_dsi0p_data = {
>>> +	/* this is possibly a gate */
>>> +	.name = "dsi0p",
>>> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
>>> +	.parents = bcm2835_clock_per_parents,
>>> +	.ctl_reg = CM_DSI0PCTL,
>>> +	.div_reg = CM_DSI0PDIV,
>>> +	.int_bits = 1,
>>> +	.frac_bits = 0,
>>> +};
>>> +
>>> +static const struct bcm2835_clock_data bcm2835_clock_dsi1p_data = {
>>> +	/* this is possibly a gate */
>>> +	.name = "dsi1p",
>>> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
>>> +	.parents = bcm2835_clock_per_parents,
>>> +	.ctl_reg = CM_DSI1PCTL,
>>> +	.div_reg = CM_DSI1PDIV,
>>> +	.int_bits = 1,
>>> +	.frac_bits = 0,
>>> +};
>> 
>> DSI0/1 pixel clocks take different clock sources and are gates off of
>> them, so these definitions don't work.
> See comment above: please provide parent clock.
> See also my comment about 3 clock that may be gates.
> 
>> 
>>> +
>>> +static const struct bcm2835_clock_data bcm2835_clock_gnric_data = {
>>> +	.name = "gnric",
>>> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
>>> +	.parents = bcm2835_clock_per_parents,
>>> +	.ctl_reg = CM_GNRICCTL,
>>> +	.div_reg = CM_GNRICDIV,
>>> +	.int_bits = 12,
>>> +	.frac_bits = 12,
>>> +};
>> 
>> GNRIC isn't an actual clock, it's just what's used for describing the
>> overall structure of clocks.
> 
> Well - there is the corresponding register at 0x7e101000 which reads as:
> ctl = 0x0000636d
> div = 0x0000636d
> 
> So we could remove this one if this is really the case of a dummy -
> even though I wonder why there would be space in io-space reserved for
> this "description" only.
> 
>> 
>>> +static const struct bcm2835_clock_data bcm2835_clock_peria_data = {
>>> +	.name = "peria",
>>> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
>>> +	.parents = bcm2835_clock_per_parents,
>>> +	.ctl_reg = CM_PERIACTL,
>>> +	.div_reg = CM_PERIADIV,
>>> +	.int_bits = 12,
>>> +	.frac_bits = 12,
>>> +};
>> 
>> This register doesn't do anything, because the debug bit in the power
>> manager is not set.  We don't think we should expose a clock gate if it
>> doesn't work, I think.
> maybe we allow setting debug in the PM at a later point in time?
> 
>> 
>>> +static const struct bcm2835_clock_data bcm2835_clock_pulse_data = {
>>> +	.name = "pulse",
>>> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
>>> +	.parents = bcm2835_clock_per_parents,
>>> +	.ctl_reg = CM_PULSECTL,
>>> +	.div_reg = CM_PULSEDIV,
>>> +	.int_bits = 12,
>>> +	.frac_bits = 0,
>>> +};
>> 
>> There's some other divider involved in this clock, won't give correct results.
> See comment above: please provide parent clock.
> 
>> 
>>> +static const struct bcm2835_clock_data bcm2835_clock_td0_data = {
>>> +	.name = "td0",
>>> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
>>> +	.parents = bcm2835_clock_per_parents,
>>> +	.ctl_reg = CM_TD0CTL,
>>> +	.div_reg = CM_TD0DIV,
>>> +	.int_bits = 12,
>>> +	.frac_bits = 12,
>>> +};
>>> +
>>> +static const struct bcm2835_clock_data bcm2835_clock_td1_data = {
>>> +	.name = "td1",
>>> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
>>> +	.parents = bcm2835_clock_per_parents,
>>> +	.ctl_reg = CM_TD1CTL,
>>> +	.div_reg = CM_TD1DIV,
>>> +	.int_bits = 12,
>>> +	.frac_bits = 12,
>>> +};
>> 
>> These are some other clock generator, not the generic or mash ones used
>> elsewhere.  I wouldn't enable them without testing.
> 
> As long as they are not referenced in the DT these only are read only
> and can get read via debugfs - these are disabled anyway:
> 
> root at raspcm:/build/linux# head /sys/kernel/debug/clk/td*/clk_rate
> ==> /sys/kernel/debug/clk/td0/clk_rate <==
> 0
> 
> ==> /sys/kernel/debug/clk/td1/clk_rate <==
> 0
> 
>> 
>>> +static const struct bcm2835_clock_data bcm2835_clock_tec_data = {
>>> +	.name = "tec",
>>> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
>>> +	.parents = bcm2835_clock_per_parents,
>>> +	.ctl_reg = CM_TECCTL,
>>> +	.div_reg = CM_TECDIV,
>>> +	.int_bits = 6,
>>> +	.frac_bits = 0,
>>> +};
>> 
>> TEC should be osc parents.
> I will change that.
> 
>> 
>>> -/*
>>> - * CM_PERIICTL (and CM_PERIACTL, CM_SYSCTL and CM_VPUCTL if
>>> - * you have the debug bit set in the power manager, which we
>>> - * don't bother exposing) are individual gates off of the
>>> - * non-stop vpu clock.
>>> - */
>>>  static const struct bcm2835_gate_data bcm2835_clock_peri_image_data = {
>>>  	.name = "peri_image",
>>>  	.parent = "vpu",
>>>  	.ctl_reg = CM_PERIICTL,
>>>  };
>>> 
>>> +static const struct bcm2835_gate_data bcm2835_clock_sys_data = {
>>> +	.name = "sys",
>>> +	.parent = "vpu",
>>> +	.ctl_reg = CM_SYSCTL,
>>> +};
>> 
>> same concern as peria.
> maybe we allow setting debug in the PM at a later point in time?
> 
> Please propose how to continue to get the clocks in.
> 
> If you want some clocks left out, then that is fine and we
> can accommodate that and just leave the defines in the bindings
> header for later use...
> 
> Just list them.
> 


As I am trying to complete the list of clocks here my ?best? summary
so far of the clock tree for the bcm2835 taken from various sources:
* Datasheet
* broadcom provided VC4 headers (via https://github.com/msperl/rpi-registers)
* mailing list

And I have come up with the following description that
you can put in graphviz or http://www.webgraphviz.com/

--- cut here ---
digraph clocks {
	graph [ordering="out"];

	subgraph cluster_osc {
		label = "Oscillators";

                "GND";
                "OSC";
                "testdebug0";
                "testdebug1";
	}

	subgraph cluster_pll {
		label = "PLLs";

		subgraph cluster_plla {
			label = "PLLA";

			OSC -> PLLA;

			PLLA -> PLLA_core;
			PLLA -> PLLA_per;
			PLLA -> PLLA_dsi0;
			PLLA -> PLLA_ccp2;
		}

		subgraph cluster_pllb {
			label = "PLLB";

			OSC -> PLLB;

			PLLB -> PLLB_ARM;
			PLLB -> PLLB_SP0;
			PLLB -> PLLB_SP1;
			PLLB -> PLLB_SP2;
		}

		subgraph cluster_pllc {
			label = "PLLC";

			OSC -> PLLC;

			PLLC -> PLLC_core0;
			PLLC -> PLLC_core1;
			PLLC -> PLLC_core2;
			PLLC -> PLLC_per;
		}

		subgraph cluster_plld {
			label = "PLLD";

			OSC -> PLLD;

			PLLD -> PLLD_core;
			PLLD -> PLLD_per;
			PLLD -> PLLD_dsi0;
			PLLD -> PLLD_dsi1;
		}

		subgraph cluster_pllh {
			label = "PLLH";

			OSC -> PLLH;

			PLLH -> PLLH_aux;
			PLLH -> PLLH_pix;
			PLLH -> PLLH_rcal;
		}
	}

	subgraph cluster_mux {
		label = "clocks";

		subgraph cluster_vpu_clocks {
			label = "VPU-clocks";

			subgraph cluster_vpu_mux {
				label = "VPU-mux";

				vGND        [label="0: GND"];
				vOSC        [label="1: OSC"];
				vtestdebug0 [label="2: testdebug0"];
				vtestdebug1 [label="3: testdebug1"];
				vPLLA_core  [label="4: PLLA_core"];
				vPLLC_core0 [label="5: PLLC_core0"];
				vPLLD_core  [label="6: PLLD_core"];
				vPLLH_aux   [label="7: PLLH_aux"];
				vPLLC_core1 [label="8: PLLC_core1"];
				vPLLC_core2 [label="9: PLLC_core2"];

				GND        -> vGND        -> vpu_mux;
				OSC        -> vOSC        -> vpu_mux;
				testdebug0 -> vtestdebug0 -> vpu_mux;
				testdebug1 -> vtestdebug1 -> vpu_mux;
				PLLA_core  -> vPLLA_core  -> vpu_mux;
				PLLC_core0 -> vPLLC_core1 -> vpu_mux;
				PLLD_core  -> vPLLD_core  -> vpu_mux;
				PLLH_aux   -> vPLLH_aux   -> vpu_mux;
				PLLC_core1 -> vPLLC_core1 -> vpu_mux;
				PLLC_core2 -> vPLLC_core2 -> vpu_mux;
			}

			vpu_mux -> vpu;
			vpu_mux -> v3d;
			vpu_mux -> isp;
			vpu_mux -> h264;
			vpu_mux -> sdram;
		}

		subgraph cluster_per_clocks {
			label = "Periperial-clocks";

			subgraph cluster_per_mux {
				label = "Periperal-mux";

				pGND        [label="0: GND"];
				pOSC        [label="1: OSC"];
				ptestdebug0 [label="2: testdebug0"];
				ptestdebug1 [label="3: testdebug1"];
				pPLLA_per   [label="4: PLLA_per"];
				pPLLC_per   [label="5: PLLC_per"];
				pPLLD_per   [label="5: PLLD_per"];
				pPLLH_aux   [label="5: PLLH_aux"];

				GND        -> pGND        -> per_mux;
				OSC        -> pOSC        -> per_mux;
				testdebug0 -> ptestdebug0 -> per_mux;
				testdebug1 -> ptestdebug1 -> per_mux;
				PLLA_per   -> pPLLA_per   -> per_mux;
				PLLC_per   -> pPLLC_per   -> per_mux;
				PLLD_per   -> pPLLD_per   -> per_mux;
				PLLH_aux   -> pPLLH_aux   -> per_mux;
			}

			per_mux -> vec;
			per_mux -> uart;
			per_mux -> hsm;
			per_mux -> emmc;
			per_mux -> pwm;
			per_mux -> pcm;
			per_mux -> aveo;
			per_mux -> cam0;
			per_mux -> cam1;
			per_mux -> dft;
			per_mux -> dpi;
			per_mux -> dsi0e;
			per_mux -> dsi1e;
			per_mux -> gp0;
			per_mux -> gp1;
			per_mux -> gp2;
			per_mux -> slim;
			per_mux -> smi;
		}

		subgraph cluster_osc_clocks {
			label = "osc-clocks";

			subgraph cluster_osc_mux {
				label = "osc-mux";

				oGND        [label="0: GND"];
				oOSC        [label="1: OSC"];
				otestdebug0 [label="2: testdebug0"];
				otestdebug1 [label="3: testdebug1"];

				GND        -> oGND        -> osc_mux;
				OSC        -> oOSC        -> osc_mux;
				testdebug0 -> otestdebug0 -> osc_mux;
				testdebug1 -> otestdebug1 -> osc_mux;
			}

			osc_mux -> tsens;
			osc_mux -> tec;
			osc_mux -> otp;
		}

		subgraph cluster_unknown_mux_clocks {
			label = "unknown-parent-mux-clocks";

			ukn_mux -> ccp2;
			ukn_mux -> dsi0pix;
			ukn_mux -> dsi1pix;
			ukn_mux -> pulse;
			ukn_mux -> td0;
			ukn_mux -> td1;
		}

		subgraph cluster_debug_clocks {
			label = "debug-clocks";

			debug_mux -> peria;
			debug_mux -> sys;
		}
	}

	subgraph cluster_aux {
		label = ?auxiliar-clocks";

		vpu -> spi1;
		vpu -> spi2;
		vpu -> uart1;
	}
}
--- cut here ---

I have no idea where we could put this information
in the kernel tree - maybe this would help.

>From this you can see that we have:
* PLL that is not configured now:
  * PLLB
* a few more PLL-dividers that are not configured:
  * PLLB_ARM
  * PLLB_SP0
  * PLLB_SP1
  * PLLB_SP2
  * PLLD_dsi0
  * PLLD_dsi1
  * PLLH_rcal
* a few clocks which Eric has said are wrong and where
  the corresponding parents need to get found:
  * ccp2 (gate)
  * dsi0pix (gate - maybe PLLD_dis0?)
  * dis1pix (gate - maybe PLLD_dis1)
  * pulse (gate)
  * td0
  * td1
* debug clocks that require a running debug power domain:
  * peria
  * sys
* missing clocks in the current driver:
  * aveo
  * cam0
  * cam1
  * ccp2 (see note above)
  * dtf
  * dpi
  * dsi0e   (maybe this also uses a different parent clock mux?)
  * dsi0pix (maybe this also uses a different parent clock mux?)
  * dsi1e   (maybe this also uses a different parent clock mux?)
  * dsi1pix (maybe this also uses a different parent clock mux?)
  * gp0
  * gp1
  * gp2
  * peria (see note above)
  * pulse (see note above)
  * slim
  * smi
  * td0 (see note above)
  * td1 (see note above)
  * td2 (see note above)
  * tec
  * sys (see note above)
* generic clock that is supposedly not in use

I can create a new patch that will include all those
missing clocks that are undisputed in their settings
(hence without any comments/notes) - I hope this is acceptable.

If someone has any ideas about those clocks where we 
miss the correct parents/mux, then please add your
wisdom.
