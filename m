From: slash.tmp@free.fr (Mason)
Date: Fri, 2 Dec 2016 19:00:49 +0100
Subject: XHCI controller does not detect USB key insertion
In-Reply-To: <96d38b62-135e-9787-e8b5-1ac3e820c23b@baylibre.com>
References: <584134D9.5000404@free.fr> <87inr2vh2l.fsf@linux.intel.com>
 <58414BC5.109@free.fr> <96d38b62-135e-9787-e8b5-1ac3e820c23b@baylibre.com>
Message-ID: <5841B6D1.4070507@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Fix incorrect address for Felipe ]

On 02/12/2016 14:46, Neil Armstrong wrote:

> On 12/02/2016 11:24 AM, Mason wrote:
>
>> (Sad face) All the documentation I have is in front of me, and nothing
>> is ringing a bell. This is a Sigma Designs SoC, with a Pravega XHCI
>> controller + Synopsys PHY.
>>
>> The documentation I have:
>>
>> Pravega_Dual_Mode_Datasheet_v10c.pdf (documents IP signals)
>> Pravega_Dual_Mode_Controller_Programmers_Reference_manual_v1.pdf (documents IP registers)
>> PHY databook (very low-level stuff)
>> SoC register mapping (for how the SoC maps the IP signals to registers)
> 
> You should have all the necessary bits to enable and configure the Embedded Synopsys PHY !
> 
> You should have some register mapping of the PHY signals, or at least a way to write those registers.
> 
> You should have a reset, clock gate and eventually a power regulator to enable in order to have the PHY running.

I'll dump all the non-0 non-standard registers. Maybe someone
more experienced than me will spot an obvious mistake.

host_usb30_0_config: 0x2e800
	- host_usb30_0_fladj                                 0x20
	- host_usb30_0_usb30_controller_cg_disable           0x0
	- host_usb30_0_mode_select                           0x1
	- host_usb30_0_device_reset_mode                     0x0

host_usb30_0_control: 0x2e804
	- host_usb30_0_app_lfps_u3_wp                        0x0
	- host_usb30_0_link_up                               0x1
	- host_usb30_0_msi_msg_sent                          0x0
	- host_usb30_0_usb3_p0_over_current                  0x0
	- host_usb30_0_usb2_p0_over_current                  0x0

host_usb30_0_test: 0x2e808
	- host_usb30_0_test_powerdown_hsp                    0x0
	- host_usb30_0_test_powerdown_ssp                    0x0
	- host_usb30_0_test_burnin                           0x0
	- host_usb30_0_acjt_level                            0x14
	- host_usb30_0_lane0_tx2rx_loopbk                    0x0
	- host_usb30_0_rtune_req                             0x0

host_usb30_0_status: 0x2e80c
	- host_usb30_0_phystatus                             0x0
	- host_usb30_0_usb2_p0_pp                            0x1
	- host_usb30_0_usb3_p0_pp                            0x1
	- host_usb30_0_usb3_sleep                            0x0
	- host_usb30_0_rtune_ack                             0x0

host_usb30_0_clk_rst_0: 0x2e810
	- host_usb30_0_commononn                             0x1
	- host_usb30_0_portreset                             0x0
	- host_usb30_0_refclksel                             0x2
	- host_usb30_0_teneable                              0x1
	- host_usb30_0_fsel                                  0x27
	- host_usb30_0_mpll_multiplier                       0x19
	- host_usb30_0_ref_clkdiv2                           0x0
	- host_usb30_0_ref_ssp_en                            0x1
	- host_usb30_0_ref_use_pad                           0x0
	- host_usb30_0_ssc_en                                0x1
	- host_usb30_0_ssc_range                             0x0

host_usb30_0_clk_rst_1: 0x2e814
	- host_usb30_0_ssc_ref_clk_sel                       0x88
	- host_usb30_0_sleepm                                0x1
	- host_usb30_0_vbusvldext                            0x1

host_usb30_0_param_0: 0x2e818
	- host_usb30_0_compdistune                           0x4
	- host_usb30_0_otgtune                               0x4
	- host_usb30_0_sqrxtune                              0x3
	- host_usb30_0_txfsltune                             0x3
	- host_usb30_0_txhsxvtune                            0x3
	- host_usb30_0_txpreempltune                         0x0
	- host_usb30_0_txpreemppulsetune                     0x0
	- host_usb30_0_txrestune                             0x1
	- host_usb30_0_txrisetune                            0x2
	- host_usb30_0_txvreftune                            0x4

host_usb30_0_param_1: 0x2e81c
	- host_usb30_0_los_bias                              0x5
	- host_usb30_0_los_level                             0xc
	- host_usb30_0_pcs_rx_los_mask_val                   0xf0
	- host_usb30_0_pcs_tx_deemph_3p5db                   0x18
	- host_usb30_0_pcs_tx_deemph_6db                     0x21

host_usb30_0_param_2: 0x2e820
	- host_usb30_0_pcs_tx_swing_full                     0x73
	- host_usb30_0_lane0_tx_term_offset                  0x0
	- host_usb30_0_tx_vboost_lvl                         0x4

host_usb30_0_SNPS_CR_ADD: 0x2e880
	- host_usb30_0_snps_cr_add                           0xe03c

DEVICE_AND_PORT_000: 0x70050000
	- sw_reset                                           0x0
	- gen_resume                                         0x0
	- ss_support                                         0x0
	- revision_id                                        0x0
	- vendor_id                                          0x3

DEVICE_AND_PORT_00C: 0x7005000c
	- set_isoc_delay                                     0x0
	- utmi_vstatus                                       0x0
	- utmi_vcontrolloadm                                 0x1
	- utmi_vcontrol                                      0x0
	- config_dev_speed                                   0x1

ENDP_CONFIG_020: 0x70050020
	- burst_size                                         0x1
	- max_packet_size_7_0                                0x0
	- rst_seq_num                                        0x0
	- iso_xact_type                                      0x0
	- stall                                              0x0
	- max_pkt_size_10_8                                  0x2
	- setup_reenable                                     0x0
	- endp_enable                                        0x1
	- endp_type                                          0x0
	- endp_no                                            0x0

LTSSM_STATE_REGISTER: 0x70050220
	- ltssm_state_status                                 0x4
	- u1_enable                                          0x0
	- u2_enable                                          0x0
	- disable_scramble_lb                                0x1
	- lfps_ux_exit                                       0x0
	- disable_scramble_request                           0x0
	- self_powered_device                                0x0
	- host_device                                        0x1
	- send_warm_reseti                                   0x0
	- send_hot_reset                                     0x0
	- reg_lgo_u3                                         0x0

PHY_TIMER_REGISTER: 0x70050410
	- u2_inactivity_timeout                              0x0
	- pending_hp_time_out                                0x2a
	- recv_resume                                        0x0
	- auto_resume                                        0x0
	- credit_hp_timer                                    0x46
	- usb3_clk_pulse_256us                               0x100

PM_LC_TIMER_REGISTER: 0x70050418
	- cntr_pulse_pm_lc_timer                             0x2a
	- cntr_pulse_pm_entry_timer                          0x54
	- lup_timeout_value                                  0xa
	- no_link_commands_timeout_value                     0xe
	- pm_lc_timer_register_reserved                      0x6e

LTSSM_TIMER_REGISTER1: 0x7005041c
	- u1_exit_timeout                                    0x54
	- u2_exit_timeout                                    0x54
	- reg_12_ms_timeout                                  0xa8

LTSSM_TIMER_REGISTER2: 0x70050420
	- reg_360_ms_timeout                                 0x34
	- pipe_width                                         0x3
	- reg_2_ms_timeout                                   0x3c
	- rxeq_timeout                                       0xffff

LTSSM_TIMER_REGISTER3: 0x70050424
	- reg_6_ms_timeout                                   0x54
	- reg_300_ms_timeout                                 0x149
	- reg_100_ms_timeout                                 0x8c
	- ltssm_timer_reg3_undef                             0x0

LOW_POWER_LFPS_SIGNALING_REGISTER: 0x70050434
	- low_power_lfps_signaling_register_value            0x4e030303
	- low_power_lfps_undef                               0x0

PING_POLLING_LFPS_SIGNALING_REGISTER: 0x70050440
	- ping_polling_lfps_signaling_register               0x9f5beebc

WARM_RESET_LFPS_SIGNALING_REGISTER: 0x70050444
	- lfps_rx_trepeat_polling                            0x5
	- lfps_wr_undef                                      0x0
	- lfps_wr_tresetdelay_min                            0x12
	- lfps_wr_tresetdelay_max                            0x0
	- lfps_wr_treset_total                               0x76

LOW_POWER_LFPS_SIGNALING_REGISTER1: 0x70050448
	- lfp_rx_undef                                       0x0
	- lfps_rx_u2_t13_t11                                 0x12
	- lfps_rx_u3_t13_t11                                 0x62
	- lfps_rx_u1_t13_t11                                 0x7
	- lfps_tx_u1_t11_t10                                 0xe
	- lfps_tx_u1_t12_t11                                 0x8
	- lfps_tx_u1_t11_t10_7_4                             0x1

LOW_POWER_LFPS_SIGNALING_REGISTER2: 0x7005044c
	- low_power_lfps_signaling_register2                 0xc34f07d0

LOW_POWER_LFPS_SIGNALING_REGISTER3: 0x70050450
	- low_power_lfps_signaling_register3                 0xc34f07d0

TIMER_ENABLE_REGISTERS: 0x70050454
	- pravega_counter_pulse_1us                          0x9
	- pravega_counter_pulse_10us                         0x9
	- pravega_counter_pulse_1ms                          0x9
	- pravega_counter_pulse_100us                        0x9
	- pravega_counter_pulse_10ms                         0x9
	- counter_pulse_100ns                                0x14


I'll take a closer look on Monday.

Regards.
