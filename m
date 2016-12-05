From: slash.tmp@free.fr (Mason)
Date: Mon, 5 Dec 2016 16:39:41 +0100
Subject: XHCI controller does not detect USB key insertion
In-Reply-To: <2b371baa-f5ed-df9b-0da8-552853b6cd79@baylibre.com>
References: <584134D9.5000404@free.fr> <87inr2vh2l.fsf@linux.intel.com>
 <58414BC5.109@free.fr> <96d38b62-135e-9787-e8b5-1ac3e820c23b@baylibre.com>
 <5841B6D1.4070507@free.fr>
 <2b371baa-f5ed-df9b-0da8-552853b6cd79@baylibre.com>
Message-ID: <58458A3D.5090001@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2016 09:26, Neil Armstrong wrote:

> On 12/02/2016 07:00 PM, Mason wrote:
>
>> On 02/12/2016 14:46, Neil Armstrong wrote:
>>
>>> On 12/02/2016 11:24 AM, Mason wrote:
>>>
>>>> (Sad face) All the documentation I have is in front of me, and nothing
>>>> is ringing a bell. This is a Sigma Designs SoC, with a Pravega XHCI
>>>> controller + Synopsys PHY.
>>>>
>>>> The documentation I have:
>>>>
>>>> Pravega_Dual_Mode_Datasheet_v10c.pdf (documents IP signals)
>>>> Pravega_Dual_Mode_Controller_Programmers_Reference_manual_v1.pdf (documents IP registers)
>>>> PHY databook (very low-level stuff)
>>>> SoC register mapping (for how the SoC maps the IP signals to registers)
>>>
>>> You should have all the necessary bits to enable and configure the Embedded Synopsys PHY !
>>>
>>> You should have some register mapping of the PHY signals, or at least a way to write those registers.
>>>
>>> You should have a reset, clock gate and eventually a power regulator to enable in order to have the PHY running.
>>
>> I'll dump all the non-0 non-standard registers. Maybe someone
>> more experienced than me will spot an obvious mistake.
>>
>> host_usb30_0_config: 0x2e800
>> 	- host_usb30_0_fladj                                 0x20
>> 	- host_usb30_0_usb30_controller_cg_disable           0x0
>> 	- host_usb30_0_mode_select                           0x1
>> 	- host_usb30_0_device_reset_mode                     0x0
>>
>> host_usb30_0_control: 0x2e804
>> 	- host_usb30_0_app_lfps_u3_wp                        0x0
>> 	- host_usb30_0_link_up                               0x1
>> 	- host_usb30_0_msi_msg_sent                          0x0
>> 	- host_usb30_0_usb3_p0_over_current                  0x0
>> 	- host_usb30_0_usb2_p0_over_current                  0x0
>>
>> host_usb30_0_test: 0x2e808
>> 	- host_usb30_0_test_powerdown_hsp                    0x0
>> 	- host_usb30_0_test_powerdown_ssp                    0x0
>> 	- host_usb30_0_test_burnin                           0x0
>> 	- host_usb30_0_acjt_level                            0x14
>> 	- host_usb30_0_lane0_tx2rx_loopbk                    0x0
>> 	- host_usb30_0_rtune_req                             0x0
>>
>> host_usb30_0_status: 0x2e80c
>> 	- host_usb30_0_phystatus                             0x0
>> 	- host_usb30_0_usb2_p0_pp                            0x1
>> 	- host_usb30_0_usb3_p0_pp                            0x1
>> 	- host_usb30_0_usb3_sleep                            0x0
>> 	- host_usb30_0_rtune_ack                             0x0
>>
>> host_usb30_0_clk_rst_0: 0x2e810
>> 	- host_usb30_0_commononn                             0x1
>> 	- host_usb30_0_portreset                             0x0
>> 	- host_usb30_0_refclksel                             0x2
>> 	- host_usb30_0_teneable                              0x1
>> 	- host_usb30_0_fsel                                  0x27
>> 	- host_usb30_0_mpll_multiplier                       0x19
>> 	- host_usb30_0_ref_clkdiv2                           0x0
>> 	- host_usb30_0_ref_ssp_en                            0x1
>> 	- host_usb30_0_ref_use_pad                           0x0
>> 	- host_usb30_0_ssc_en                                0x1
>> 	- host_usb30_0_ssc_range                             0x0
>>
>> host_usb30_0_clk_rst_1: 0x2e814
>> 	- host_usb30_0_ssc_ref_clk_sel                       0x88
>> 	- host_usb30_0_sleepm                                0x1
>> 	- host_usb30_0_vbusvldext                            0x1
>>
>> host_usb30_0_param_0: 0x2e818
>> 	- host_usb30_0_compdistune                           0x4
>> 	- host_usb30_0_otgtune                               0x4
>> 	- host_usb30_0_sqrxtune                              0x3
>> 	- host_usb30_0_txfsltune                             0x3
>> 	- host_usb30_0_txhsxvtune                            0x3
>> 	- host_usb30_0_txpreempltune                         0x0
>> 	- host_usb30_0_txpreemppulsetune                     0x0
>> 	- host_usb30_0_txrestune                             0x1
>> 	- host_usb30_0_txrisetune                            0x2
>> 	- host_usb30_0_txvreftune                            0x4
>>
>> host_usb30_0_param_1: 0x2e81c
>> 	- host_usb30_0_los_bias                              0x5
>> 	- host_usb30_0_los_level                             0xc
>> 	- host_usb30_0_pcs_rx_los_mask_val                   0xf0
>> 	- host_usb30_0_pcs_tx_deemph_3p5db                   0x18
>> 	- host_usb30_0_pcs_tx_deemph_6db                     0x21
>>
>> host_usb30_0_param_2: 0x2e820
>> 	- host_usb30_0_pcs_tx_swing_full                     0x73
>> 	- host_usb30_0_lane0_tx_term_offset                  0x0
>> 	- host_usb30_0_tx_vboost_lvl                         0x4
>>
>> host_usb30_0_SNPS_CR_ADD: 0x2e880
>> 	- host_usb30_0_snps_cr_add                           0xe03c
> 
> This is obviously the PHY registers.
> 
> Commonly, the PHY from Synopsys does not have a register interface given by Synopsys, but it's in charge
> of the SoC integrator to add a register set to program all the PHY signals.

Apparently, it was decided to map all Synopsys registers through
a single address/data register pair.

> Typically, those signal will contain some Clock selection, Enable Reset, Tunings and VBUS mode selection.

The Synopsys datasheet mentions two register blocks:

SS Function Control Registers (SS for SuperSpeed i.e. USB3, I guess)
HS Function Control Registers (HS for HighSpeed  i.e. USB2, I guess)

The registers in the first block are:

SUP.IDCODE_LO
SUP.IDCODE_HI
SUP.DEBUG
RTUNE_DEBUG
RTUNE_STAT
SS_PHASE
SS_FREQ
ATEOVRD
MPLL_OVRD_IN_LO
MPLL_OVRD_IN_HI
SSC_OVRD_IN
BS_OVRD_IN
LEVEL_OVRD_IN
SUP_OVRD_OUT
MPLL_ASIC_IN
BS_ASIC_IN
LEVEL_ASIC_IN
SSC_ASIC_IN
SUP_ASIC_OUT
ATEOVRD_STATUS
SCOPE_ENABLES
SCOPE_SAMPLES
SCOPE_COUNT
SCOPE_CTL
SCOPE_MASK_000
SCOPE_MASK_001
SCOPE_MASK_010
SCOPE_MASK_011
SCOPE_MASK_100
SCOPE_MASK_101
SCOPE_MASK_110
SCOPE_MASK_111
MPLL_LOOP_CTL
MPLL_ATB_MEAS1
MPLL_ATB_MEAS2
MPLL_OVRD
RTUNE_RTUNE_CTRL
ATB_SWITCHYARD_CTRL
SSC_CLK_CNTRL
LANE0.TX_OVRD_IN_LO
LANE0.TX_OVRD_IN_HI
LANE0.TX_OVRD_DRV_LO
LANE0.TX_OVRD_DRV_HI
LANE0.TX_OVRD_OUT
LANE0.RX_OVRD_IN_LO
LANE0.RX_OVRD_IN_HI
LANE0.RX_OVRD_OUT
LANE0.TX_ASIC_IN
LANE0.TX_ASIC_DRV_LO
LANE0.TX_ASIC_DRV_HI
TX_ASIC_OUT
RX_ASIC_IN
RX_ASIC_OUT
LANE0.TX_DEBUG
LANE0.TX_CM_WAIT_TIME_OVRD
LANE0.TX_VMD_FSM_TX_VCM_0
LANE0.TX_VMD_FSM_TX_VCM_1
LANE0.TX_LBERT_CTL
LANE0.RX_LBERT_CTL
LANE0.RX_LBERT_ERR
LANE0.RX_SCOPE_CTL
LANE0.RX_SCOPE_PHASE
LANE0.RX_DPLL_FREQ
LANE0.RX_CDR_CTL
LANE0.RX_CDR_CDR_FSM_DEBUG
LANE0.RX_CDR_LOCK_VEC_OVRD
LANE0.RX_CDR_LOCK_VEC
LANE0.RX_CDR_ADAP_FSM


The one register with clk in the name is SSC_CLK_CNTRL.
It has a 7-bit sub-field called SSC_CLK_DIV125.
"Sets SSC reference clock to 20 MHz." Default val = 7
/me blank stare ...

> commononn seems top be an enable, but active low
> portreset seems to be used to reset the port
> refclksel seem to select the clock source (you should have either an external Xtal, SoX Xtal or a PLL output)

These are PHY signals, which are mapped to registers in
my SoC, AFAICT.

COMMONONN
Common Block Power-Down Control
Function: Controls the power-down signals in the HS Bias and PLL blocks
when the USB 3.0 PHY is in Suspend or Sleep mode.
- 1: In Suspend or Sleep mode, the HS Bias and PLL blocks are powered down.
- 0: In Suspend or Sleep mode, the HS Bias and PLL blocks remain powered and continue to draw current.

PORTRESET<#>
Per-Port Reset
Function: When asserted, this customer-specific signal resets the
corresponding port's USB2.0 transmit and receive logic without disabling the
clocks within the USB 3.0 PHY.
- 1: The transmit and receive finite state machines (FSMs) are reset, and the
line_state logic combinatorially reflects the state of the single-ended
receivers.
- 0: The transmit and receive FSMs are operational, and the line_state logic
becomes sequential after 11 PHYCLOCK<#> cycles.
Asserting PORTRESET<#> does not override any USB 3.0 PHY inputs that
normally control the USB 2.0 state, nor does it cause any transient, illegal USB
states.
Within 100 ns of asserting PORTRESET<#>, the controller must set the inputs
that control the USB 2.0 to values that cause a safe state.
A safe state for Host and Device modes is defined as follows:
- Host mode: Non-driving (OPMODE<#>[1:0] = 2'b01) with the 15-k? pull-
down resistors enabled (DPPULLDOWN<#> and DMPULLDOWN<#> = 1'b1)
- Device mode: Non-driving (OPMODE<#>[1:0] = 2'b01) with the 1.5-k? pull-
up resistor disabled

REFCLKSEL[1:0]
Reference Clock Select for PLL Block
Function: Selects reference clock source for the HS PLL block.
- 11: HS PLL uses EXTREFCLK as reference.
- 10: HS PLL uses either ref_pad_clk{p,m} or ref_alt_clk_{p,m} as reference.
- 0x: Reserved
This bus is a strapping option that must be set prior to a power-on reset and
remain static during normal operation. Strapping options are not critical for STA,
and any other timings or loading limits for the pin are specified in the .lib timing
model included in the product deliverables.


> Please look at your "PHY databook" how these signals should be configured.
> Be aware that some "tune" register should have been calibrated in fab somehow, so you should make sure the reset values are correct.

Hmmm... Taking a closer look at the 280-page PHY documentation...

3.2 Clocks and Resets
The USB 3.0 PHY supports a wide range of input reference clocks from both
external and on-chip clock sources.
To support both SuperSpeed and high-speed operations, one of the following must be provided:
- A compatible, shared reference clock frequency
- Separate clock sources to support SuperSpeed operation and high-speed operation

I checked that specific configuration requirement.
(Table 3-3 Reference Clock Frequency Selection for SuperSpeed Operation)
and it does look like one of the arbitrary values was not correctly set
ssc_ref_clk_sel was 0x88 instead of 0x0 (for 100 MHz input clock).
But "fixing" that didn't make the controller detect my USB2 key (or a USB3 hub).


pipeP_phystatus is as an output signal documented as
PIPE PHY Status
Function: Communicates completion of several PHY functions including power
management state transitions, rate change, and receiver detection. When this
signal transitions during entry and exit from P3 states and PCLK is not running,
the signaling is asynchronous. In error situations (where the PHY fails to assert
PhyStatus), the MAC can take MAC-specific error recovery actions.

I think it's a bad sign that it remains at 0.
(Assuming host_usb30_0_phystatus and pipeP_phystatus are the same)


Hmmm, I think it's time to punt this task to a HW engineer, and let them
figure out what is required for basic functionality. Only then can I try
to make the Linux driver play nice with the HW block.

Regards.
