From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 17 Feb 2016 21:01:52 +0100 (CET)
Subject: [PATCH V4 5/7] clk: bcm2835: add missing 22 HW-clocks.
In-Reply-To: <A977D3F2-1F64-41C8-B8ED-EB9F0B3554B9@martin.sperl.org>
References: <1452867667-2447-1-git-send-email-kernel@martin.sperl.org>
 <1452867667-2447-6-git-send-email-kernel@martin.sperl.org>
 <87h9hr517u.fsf@eliezer.anholt.net> <56B8782C.4060107@martin.sperl.org>
 <A977D3F2-1F64-41C8-B8ED-EB9F0B3554B9@martin.sperl.org>
Message-ID: <704229577.519481.7acc7698-e68b-4f4b-8da5-f03a550266a8.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Martin Sperl <kernel@martin.sperl.org> hat am 17. Februar 2016 um 19:25
> geschrieben:
>
> As I am trying to complete the list of clocks here my ?best? summary
> so far of the clock tree for the bcm2835 taken from various sources:
> * Datasheet
> * broadcom provided VC4 headers (via https://github.com/msperl/rpi-registers)
> * mailing list
>
> And I have come up with the following description that
> you can put in graphviz or http://www.webgraphviz.com/
>
> --- cut here ---
> digraph clocks {
> graph [ordering="out"];
>
> subgraph cluster_osc {
> label = "Oscillators";
>
> "GND";
> "OSC";
> "testdebug0";
> "testdebug1";
> }
>
> subgraph cluster_pll {
> label = "PLLs";
>
> subgraph cluster_plla {
> label = "PLLA";
>
> OSC -> PLLA;
>
> PLLA -> PLLA_core;
> PLLA -> PLLA_per;
> PLLA -> PLLA_dsi0;
> PLLA -> PLLA_ccp2;
> }
>
> subgraph cluster_pllb {
> label = "PLLB";
>
> OSC -> PLLB;
>
> PLLB -> PLLB_ARM;
> PLLB -> PLLB_SP0;
> PLLB -> PLLB_SP1;
> PLLB -> PLLB_SP2;
> }
>
> subgraph cluster_pllc {
> label = "PLLC";
>
> OSC -> PLLC;
>
> PLLC -> PLLC_core0;
> PLLC -> PLLC_core1;
> PLLC -> PLLC_core2;
> PLLC -> PLLC_per;
> }
>
> subgraph cluster_plld {
> label = "PLLD";
>
> OSC -> PLLD;
>
> PLLD -> PLLD_core;
> PLLD -> PLLD_per;
> PLLD -> PLLD_dsi0;
> PLLD -> PLLD_dsi1;
> }
>
> subgraph cluster_pllh {
> label = "PLLH";
>
> OSC -> PLLH;
>
> PLLH -> PLLH_aux;
> PLLH -> PLLH_pix;
> PLLH -> PLLH_rcal;
> }
> }
>
> subgraph cluster_mux {
> label = "clocks";
>
> subgraph cluster_vpu_clocks {
> label = "VPU-clocks";
>
> subgraph cluster_vpu_mux {
> label = "VPU-mux";
>
> vGND [label="0: GND"];
> vOSC [label="1: OSC"];
> vtestdebug0 [label="2: testdebug0"];
> vtestdebug1 [label="3: testdebug1"];
> vPLLA_core [label="4: PLLA_core"];
> vPLLC_core0 [label="5: PLLC_core0"];
> vPLLD_core [label="6: PLLD_core"];
> vPLLH_aux [label="7: PLLH_aux"];
> vPLLC_core1 [label="8: PLLC_core1"];
> vPLLC_core2 [label="9: PLLC_core2"];
>
> GND -> vGND -> vpu_mux;
> OSC -> vOSC -> vpu_mux;
> testdebug0 -> vtestdebug0 -> vpu_mux;
> testdebug1 -> vtestdebug1 -> vpu_mux;
> PLLA_core -> vPLLA_core -> vpu_mux;
> PLLC_core0 -> vPLLC_core1 -> vpu_mux;
> PLLD_core -> vPLLD_core -> vpu_mux;
> PLLH_aux -> vPLLH_aux -> vpu_mux;
> PLLC_core1 -> vPLLC_core1 -> vpu_mux;
> PLLC_core2 -> vPLLC_core2 -> vpu_mux;
> }
>
> vpu_mux -> vpu;
> vpu_mux -> v3d;
> vpu_mux -> isp;
> vpu_mux -> h264;
> vpu_mux -> sdram;
> }
>
> subgraph cluster_per_clocks {
> label = "Periperial-clocks";
>
> subgraph cluster_per_mux {
> label = "Periperal-mux";
>
> pGND [label="0: GND"];
> pOSC [label="1: OSC"];
> ptestdebug0 [label="2: testdebug0"];
> ptestdebug1 [label="3: testdebug1"];
> pPLLA_per [label="4: PLLA_per"];
> pPLLC_per [label="5: PLLC_per"];
> pPLLD_per [label="5: PLLD_per"];
> pPLLH_aux [label="5: PLLH_aux"];
>
> GND -> pGND -> per_mux;
> OSC -> pOSC -> per_mux;
> testdebug0 -> ptestdebug0 -> per_mux;
> testdebug1 -> ptestdebug1 -> per_mux;
> PLLA_per -> pPLLA_per -> per_mux;
> PLLC_per -> pPLLC_per -> per_mux;
> PLLD_per -> pPLLD_per -> per_mux;
> PLLH_aux -> pPLLH_aux -> per_mux;
> }
>
> per_mux -> vec;
> per_mux -> uart;
> per_mux -> hsm;
> per_mux -> emmc;
> per_mux -> pwm;
> per_mux -> pcm;
> per_mux -> aveo;
> per_mux -> cam0;
> per_mux -> cam1;
> per_mux -> dft;
> per_mux -> dpi;
> per_mux -> dsi0e;
> per_mux -> dsi1e;
> per_mux -> gp0;
> per_mux -> gp1;
> per_mux -> gp2;
> per_mux -> slim;
> per_mux -> smi;
> }
>
> subgraph cluster_osc_clocks {
> label = "osc-clocks";
>
> subgraph cluster_osc_mux {
> label = "osc-mux";
>
> oGND [label="0: GND"];
> oOSC [label="1: OSC"];
> otestdebug0 [label="2: testdebug0"];
> otestdebug1 [label="3: testdebug1"];
>
> GND -> oGND -> osc_mux;
> OSC -> oOSC -> osc_mux;
> testdebug0 -> otestdebug0 -> osc_mux;
> testdebug1 -> otestdebug1 -> osc_mux;
> }
>
> osc_mux -> tsens;
> osc_mux -> tec;
> osc_mux -> otp;
> }
>
> subgraph cluster_unknown_mux_clocks {
> label = "unknown-parent-mux-clocks";
>
> ukn_mux -> ccp2;
> ukn_mux -> dsi0pix;
> ukn_mux -> dsi1pix;
> ukn_mux -> pulse;
> ukn_mux -> td0;
> ukn_mux -> td1;
> }
>
> subgraph cluster_debug_clocks {
> label = "debug-clocks";
>
> debug_mux -> peria;
> debug_mux -> sys;
> }
> }
>
> subgraph cluster_aux {
> label = ?auxiliar-clocks";
>
> vpu -> spi1;
> vpu -> spi2;
> vpu -> uart1;
> }
> }
> --- cut here ---
>
> I have no idea where we could put this information
> in the kernel tree - maybe this would help.
>

Documentation/devicetree/bindings/clock/brcm,bcm2835-cprman.txt should be a good
place.
