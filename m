From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 19 Apr 2017 22:25:02 +0200 (CEST)
Subject: usb: dwc2: NMI watchdog: BUG: soft lockup - CPU#0 stuck for 146s
In-Reply-To: <CAD=FV=VHkJFrsJDmMytbUw=WjKQaGZ-8Ewfy5bPCA82AWS4O2Q@mail.gmail.com>
References: <1795308650.27171.9a53158f-312d-40ce-80ce-8bf792d8db34.open-xchange@email.1und1.de>
 <172093673.40121.1492427140661@email.1und1.de>
 <CAD=FV=WJBTUcMPw8OgQT_jhz0H8AsH=YqWMR7LtudUKrF5-XOA@mail.gmail.com>
 <79b9b35b-0600-771f-4cd2-9e03c5ba3a25@i2se.com>
 <186569458.91967.1492547106553@email.1und1.de>
 <CAD=FV=VHkJFrsJDmMytbUw=WjKQaGZ-8Ewfy5bPCA82AWS4O2Q@mail.gmail.com>
Message-ID: <212870399.174480.1492633502649@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Doug Anderson <dianders@chromium.org> hat am 18. April 2017 um 22:41 geschrieben:
> 
> 
> It's hard to know for sure that all of this time is really in
> urb_enqueue().  Possible we could have task switched out and been
> blocked elsewhere.  Using ftrace to get more fine-grained timings
> would be useful.  ktime_get(), ktime_sub(), and ktime_to_us() are your
> friends here if you want to use trace_printk.

i'm a newbie to ftrace, so i hope this would be helpful.

# connect PL2303 to the onboard hub
# echo 0 > options/sleep-time
# echo 0 > function_profile_enabled
# echo 1 > function_profile_enabled
# ./usb_test
# Waiting for at least 20 seconds and then disconnect PL2303
# echo 0 > function_profile_enabled
# cat trace_stat/function0

  Function                               Hit    Time            Avg             s^2
  --------                               ---    ----            ---             ---
  bcm2835_handle_irq                  361347    219567633 us     607.636 us      1485199 us  
  __handle_domain_irq                1082482    212639551 us     196.437 us      3642030 us  
  generic_handle_irq                 1082482    100592051 us     92.927 us       50511334 us 
  irq_exit                           1082482    98197771 us     90.715 us       29649040 us 
  handle_level_irq                   1082482    95812379 us     88.511 us       51910093 us 
  do_sys_open                           1806    87612983 us     48512.17 us     2198507 us  
  SyS_open                              1601    87372331 us     54573.59 us     1898996 us  
  do_filp_open                          1862    87368058 us     46921.62 us     1634982 us  
  path_openat                           1862    87314553 us     46892.88 us     3357817 us  
  __do_softirq                          3035    86266050 us     28423.73 us     6449768 us  
  vfs_open                              1515    85877012 us     56684.49 us     101673.5 us 
  do_dentry_open                        1515    85861429 us     56674.21 us     812420.7 us 
  usb_submit_urb                         136    85760172 us     630589.5 us     59532024 us 
  usb_hcd_submit_urb                     134    85756518 us     639974.0 us     726298102 us 
  _dwc2_hcd_urb_enqueue                  134    85738333 us     639838.3 us     874104371 us 
  chrdev_open                             87    85716519 us     985247.3 us     1951112835 us 
  tty_open                                 3    85714494 us     28571498 us     3743206849 us 
  tty_port_open                            3    85712603 us     28570867 us     1968003468 us 
  serial_open                              1    85712472 us     85712472 us     0.000 us    
  serial_port_activate                     1    85709890 us     85709890 us     0.000 us    
  pl2303_open                              1    85709875 us     85709875 us     0.000 us    
  usb_serial_generic_open                  1    85701170 us     85701170 us     0.000 us    
  usb_serial_generic_submit_read           1    85701166 us     85701166 us     0.000 us    
  usb_serial_generic_submit_read           2    85701160 us     42850580 us     2252410463 us 
  handle_irq_event                   1082482    80686112 us     74.538 us       36417905 us 
  handle_irq_event_percpu            1082482    78398378 us     72.424 us       34060119 us 
  __handle_irq_event_percpu          1082482    68466046 us     63.249 us       53609076 us 
  usb_hcd_irq                        1078945    59761116 us     55.388 us       25139388 us 
  _dwc2_hcd_irq                      1078945    57481606 us     53.275 us       30847036 us 
  dwc2_handle_hcd_intr               1078945    55380910 us     51.328 us       35986237 us 
  do_idle                                394    43577379 us     110602.4 us     84278209 us 
  dwc2_hc_n_intr                      651065    42408491 us     65.137 us       7281229 us  
  default_idle_call                   229969    38021287 us     165.332 us      11386904 us 
  arch_cpu_idle                       229969    37379305 us     162.540 us      2168909 us  
  dwc2_halt_channel                   650811    34208348 us     52.562 us       7792012 us  
  dwc2_release_channel                651065    33042638 us     50.751 us       8112754 us  
  dwc2_hc_nak_intr                    334689    18892951 us     56.449 us       1823592 us  
  dwc2_hc_ack_intr                    315986    18323433 us     57.988 us       151346.6 us 
  dwc2_hcd_select_transactions       1730010    11694955 us     6.760 us        1188442 us  
  dwc2_hcd_queue_transactions         651065    10931854 us     16.790 us       952074.2 us 
  dwc2_assign_and_init_hc             651065    9540885 us      14.654 us       258067.1 us 
  dwc2_queue_transaction              651065    9192559 us      14.119 us       736431.6 us 
  tick_nohz_irq_exit                  325055    9052192 us      27.848 us       916293.3 us 
  __tick_nohz_idle_enter.constpr      324760    8463861 us      26.061 us       2410440 us  
  dwc2_hc_start_transfer              651065    7687376 us      11.807 us       625773.3 us 
  irq_enter                          1082482    6627959 us      6.122 us        11528932 us 
  arm_heavy_mb                      10903913    6603586 us      0.605 us        60562924 us 
  unmask_irq                         1082482    4763699 us      4.400 us        1032638 us  
  tick_irq_enter                      326467    4377088 us      13.407 us       4606805 us  
  dwc2_handle_common_intr            1078945    3799392 us      3.521 us        1131504 us  
  add_interrupt_randomness           1082482    3542044 us      3.272 us        30545511 us 
  get_next_armctrl_hwirq             1443829    3276974 us      2.269 us        2116848 us  
  tick_nohz_restart                    70325    3250462 us      46.220 us       35710.73 us 
  dwc2_hc_cleanup                     651065    3079003 us      4.729 us        81202.50 us 
  dwc2_hcd_qh_deactivate              651065    3039940 us      4.669 us        90928.10 us 
  ledtrig_cpu                         459938    2450327 us      5.327 us        1466705 us  
  arch_cpu_idle_exit                  229969    2443315 us      10.624 us       8606787 us  
  do_page_fault                         5509    2304998 us      418.405 us      17961439 us 
  ktime_get                           795998    2121741 us      2.665 us        166119.5 us 
  get_next_timer_interrupt            324760    1998999 us      6.155 us        32201.63 us 
  handle_mm_fault                       5537    1945500 us      351.363 us      8324917 us  
  dwc2_is_controller_alive           2157890    1473590 us      0.682 us        291399.4 us 
  hrtimer_cancel                       70450    1394330 us      19.791 us       36980.28 us 
  arch_cpu_idle_enter                 229969    1350759 us      5.873 us        10789.94 us 
  hrtimer_try_to_cancel                71029    1266967 us      17.837 us       30260.75 us 
  filemap_map_pages                     1632    1263006 us      773.900 us      207846.4 us 
  tick_program_event                  141799    1260485 us      8.889 us        9343.194 us 
  hrtimer_start_range_ns               97555    1253698 us      12.851 us       43166.94 us 
  irq_to_desc                        1082482    1146955 us      1.059 us        546937.6 us 
  link_path_walk                        3486    1134351 us      325.401 us      484443.0 us 
  __remove_hrtimer                     99205    999724.0 us     10.077 us       201933.9 us 
  clockevents_program_event           141799    985346.0 us     6.948 us        7114.725 us 
  note_interrupt                     1082482    899494.0 us     0.830 us        705141.6 us 
  update_ts_time_stats.constprop      324760    862996.0 us     2.657 us        21813.81 us 
  alloc_set_pte                        20011    805880.0 us     40.271 us       1086748 us  
  SyS_read                              1940    805061.0 us     414.979 us      164198.7 us 
  _local_bh_enable                    326467    777908.0 us     2.382 us        37202.43 us 
  vfs_read                              2080    761487.0 us     366.099 us      22944777 us 
  dwc2_hcd_get_frame_number          1097673    721108.0 us     0.656 us        525348.1 us 
  do_munmap                             1194    717161.0 us     600.637 us      65635.31 us 
  schedule                              3297    700578.0 us     212.489 us      28594.59 us 
  __vfs_read                            2080    694376.0 us     333.834 us      21955675 us 
  walk_component                        9912    683211.0 us     68.927 us       349771.7 us 
  irq_find_mapping                   1082482    673162.0 us     0.621 us        900861.5 us 
  __next_timer_interrupt              324929    667175.0 us     2.053 us        4576.720 us 
  armctrl_translate_shortcut         1079274    662875.0 us     0.614 us        164464.8 us 
  filename_lookup                       1316    646059.0 us     490.926 us      148884.8 us 
  mmput                                  259    644417.0 us     2488.096 us     33155247 us 
  armctrl_unmask_irq                 1082482    639692.0 us     0.590 us        891074.7 us 
  armctrl_mask_irq                   1082482    636505.0 us     0.588 us        888583.1 us 
  exit_mmap                               45    634389.0 us     14097.53 us     24105769 us 
  irq_state_set_masked               1082482    622182.0 us     0.574 us        894212.6 us 
  user_path_at_empty                    1156    620229.0 us     536.530 us      166865.3 us 
  SyS_munmap                             895    600613.0 us     671.075 us      75763.68 us 
  vm_mmap_pgoff                         1437    598955.0 us     416.809 us      55882.41 us 
  read_current_timer                 1082666    598757.0 us     0.553 us        86817.59 us 
  irq_may_run                        1082482    598471.0 us     0.552 us        898308.6 us 
  vm_munmap                              937    595309.0 us     635.335 us      70914.31 us 
  path_lookupat                         1316    592448.0 us     450.188 us      147624.4 us 
  SyS_mmap_pgoff                        1325    588992.0 us     444.522 us      62142.49 us 
  irq_state_clr_masked               1082482    582077.0 us     0.537 us        893572.4 us 
  idle_cpu                           1082482    580428.0 us     0.536 us        905609.5 us 
  do_execve                               28    573864.0 us     20495.14 us     98356111 us 
  do_execveat_common                      28    573576.0 us     20484.85 us     98471441 us 
  dwc2_hc_set_even_odd_frame          651065    570127.0 us     0.875 us        543701.5 us 
  ledtrig_cpu.part.0                  229969    549060.0 us     2.387 us        9142.920 us 
  do_mmap                               1437    548817.0 us     381.918 us      54270.64 us 
  do_work_pending                       2211    525805.0 us     237.813 us      234836.0 us 
  led_trigger_event                   460228    501093.0 us     1.088 us        4759241 us  
  search_binary_handler                   28    501026.0 us     17893.78 us     93445723 us 
  clocksource_mmio_readl_up           807791    500765.0 us     0.619 us        91050.42 us 
  load_elf_binary                         28    500359.0 us     17869.96 us     93309220 us 
  process_one_work                       558    496994.0 us     890.670 us      7196614 us  
  tick_do_update_jiffies64            324826    496168.0 us     1.527 us        3422867 us  
  hrtimer_forward                      72095    490887.0 us     6.808 us        4548.034 us 
  unmap_vmas                            1239    490538.0 us     395.914 us      2723415 us  
  finish_task_switch                    3926    479983.0 us     122.257 us      25336.71 us 
  unmap_single_vma                      3403    474812.0 us     139.527 us      959184.6 us 
  __sync_icache_dcache                 27231    468069.0 us     17.188 us       364740.1 us 
  SyS_execve                              16    462210.0 us     28888.12 us     4450186 us  
  unmap_region                          1194    460297.0 us     385.508 us      44372.58 us 
  unmap_page_range                      3403    455941.0 us     133.982 us      956896.1 us 
  bcm2835_time_interrupt                3208    455584.0 us     142.014 us      56012.72 us 
  mmap_region                           1437    449599.0 us     312.873 us      55175.49 us 
  hrtimer_interrupt                     3208    443908.0 us     138.375 us      55446.73 us 
  dwc2_hcd_qh_add                     632341    436511.0 us     0.690 us        58787.66 us 
  lookup_fast                          11601    436227.0 us     37.602 us       570183.6 us 
  inode_permission                     14699    426528.0 us     29.017 us       404007.8 us 
  SyS_access                             561    412200.0 us     734.759 us      146663.8 us 
  dwc2_hcd_qh_unlink                  632344    410157.0 us     0.648 us        87505.07 us 
  seq_read                               669    408885.0 us     611.188 us      226703.8 us 
  SyS_faccessat                          564    406969.0 us     721.576 us      141955.4 us 
  dwc2_check_qtd_still_ok             651065    392283.0 us     0.602 us        59460.80 us 
  SyS_getdents64                         392    379673.0 us     968.553 us      13678636 us 
  SyS_write                              404    378782.0 us     937.579 us      254399.0 us 
  iterate_dir                            393    367777.0 us     935.819 us      13659529 us 
  vfs_write                              404    358326.0 us     886.945 us      240956.8 us 
  __hrtimer_run_queues.constprop        3227    357720.0 us     110.852 us      47783.12 us 
  task_work_run                         1460    350902.0 us     240.343 us      71379.18 us 
  _cond_resched                       109971    344855.0 us     3.135 us        2245087 us  
  __vfs_write                            404    333260.0 us     824.900 us      230347.3 us 
  ____fput                              1680    326232.0 us     194.185 us      40913.99 us 
  __inode_permission                   14699    324102.0 us     22.049 us       328791.7 us 
  __fput                                1680    316285.0 us     188.264 us      40874.09 us 
  flush_old_exec                          28    313336.0 us     11190.57 us     96843591 us 
  tick_sched_timer                      1964    312793.0 us     159.263 us      2002.533 us 
  do_wp_page                            1758    300693.0 us     171.042 us      17667.03 us 
  _do_fork                                29    281388.0 us     9703.034 us     54207832 us 
  copy_process.part.4                     29    273985.0 us     9447.758 us     53888393 us 
  SyS_clone                               17    267170.0 us     15715.88 us     2444683 us  
  free_pgtables                         1239    265593.0 us     214.360 us      500428.0 us 
  dput                                 15879    265579.0 us     16.725 us       269685.7 us 
  SyS_openat                             205    258191.0 us     1259.468 us     209643.6 us 
  pfn_valid                            18146    257726.0 us     14.202 us       121416.6 us 
  update_wall_time                      5957    250787.0 us     42.099 us       619.230 us  
  mmc_blk_issue_rq                        63    246608.0 us     3914.412 us     8858815 us  
  mmc_blk_issue_rw_rq                     63    241626.0 us     3835.333 us     8884205 us  
  vfs_statx                              441    232198.0 us     526.526 us      150124.0 us 
  SyS_sendmsg                            316    226698.0 us     717.398 us      164208.5 us 
  mmc_start_request                      145    225615.0 us     1555.965 us     5542154 us  
  __sys_sendmsg                          316    223856.0 us     708.405 us      164907.1 us 
  wp_page_copy                          1061    222841.0 us     210.029 us      13010.76 us 
  __generic_file_write_iter              206    219092.0 us     1063.553 us     242948.7 us 
  terminate_walk                        3225    217649.0 us     67.488 us       47336.14 us 
  ext4_file_write_iter                   170    216280.0 us     1272.235 us     127738.3 us 
  __mmc_start_request                    145    214090.0 us     1476.482 us     5509235 us  
  ___sys_sendmsg                         316    212732.0 us     673.202 us      161410.8 us 
  kmem_cache_alloc                     17570    210590.0 us     11.985 us       120917.2 us 
  mmc_start_areq                          63    210528.0 us     3341.714 us     9610382 us  
  sdhci_request                          145    209828.0 us     1447.089 us     5547701 us  
  sock_sendmsg                           353    208523.0 us     590.716 us      147666.9 us 
  __split_vma                            981    206458.0 us     210.456 us      13253.43 us 
  credit_entropy_bits                  16914    205434.0 us     12.145 us       208.830 us  
  hrtimer_get_next_event              324760    199659.0 us     0.614 us        17454.58 us 
  path_put                              6090    196782.0 us     32.312 us       54264.43 us 
  SyS_mprotect                           427    193190.0 us     452.435 us      42168.10 us 
  SyS_stat64                             370    181587.0 us     490.775 us      119707.4 us 
  nr_iowait_cpu                       324760    176767.0 us     0.544 us        17782.33 us 
  __vma_adjust                          1452    174253.0 us     120.008 us      5746.323 us 
  tick_sched_handle                     1964    174004.0 us     88.596 us       419.232 us  
  sdhci_irq                              211    173984.0 us     824.568 us      4212897 us  
  touch_softlockup_watchdog_sche      323207    173767.0 us     0.537 us        108651.0 us 
  kernfs_iop_permission                 5012    173442.0 us     34.605 us       21830.09 us 
  __local_bh_enable                   329502    172898.0 us     0.524 us        9002.660 us 
  proc_single_show                       233    170938.0 us     733.639 us      235941.1 us 
  mprotect_fixup                         455    163622.0 us     359.608 us      43581.82 us 
  SyS_recvmsg                            515    163337.0 us     317.159 us      23749.85 us 
  update_process_times                  1964    161227.0 us     82.091 us       436.558 us  
  usb_control_msg                        131    160306.0 us     1223.709 us     63779.20 us 
  __sys_recvmsg                          515    159685.0 us     310.067 us      23888.88 us 
  check_carrier                           29    159209.0 us     5489.965 us     157176.1 us 
  __dentry_kill                         1306    159044.0 us     121.779 us      13522.69 us 
  smsc95xx_mdio_read                      29    156605.0 us     5400.172 us     147578.2 us 
  __smsc95xx_mdio_read                    29    156128.0 us     5383.724 us     153872.9 us 
  ext4_readdir                            60    152036.0 us     2533.933 us     67111799 us 
  run_ksoftirqd                          844    151846.0 us     179.912 us      74010.42 us 
  usb_start_wait_urb                     131    151181.0 us     1154.053 us     59721.86 us 
  find_vma                              8806    149418.0 us     16.967 us       419885.5 us 
  __alloc_pages_nodemask                4365    143647.0 us     32.908 us       22236.43 us 
  ___sys_recvmsg                         515    143567.0 us     278.770 us      23183.05 us 
  memblock_is_map_memory               18146    142969.0 us     7.878 us        62191.29 us 
  timekeeping_max_deferment           252165    141177.0 us     0.559 us        3782.924 us 
  unlink_anon_vmas                      3403    137080.0 us     40.282 us       17090.37 us 
  __vma_link_rb                         3403    136104.0 us     39.995 us       12357.79 us 
  rcu_process_callbacks                 1050    135701.0 us     129.239 us      66292.86 us 
  SyS_close                             1977    135041.0 us     68.306 us       4406.697 us 
  pick_next_task_fair                   3996    133622.0 us     33.438 us       1391.499 us 
  proc_readfd                             50    133185.0 us     2663.700 us     18788258 us 
  proc_readfd_common                      50    132911.0 us     2658.220 us     18769391 us 
  generic_perform_write                  206    132888.0 us     645.087 us      134152.0 us 
  __mix_pool_bytes                     16914    128343.0 us     7.587 us        303.814 us  
  run_timer_softirq                     1960    127980.0 us     65.295 us       13337.43 us 
  timekeeping_update                    5956    127128.0 us     21.344 us       147.035 us  
  try_to_wake_up                        2348    125639.0 us     53.508 us       5318.431 us 
  ktime_add_safe                      241886    125624.0 us     0.519 us        6352.310 us 
  __rcu_process_callbacks               2100    125522.0 us     59.772 us       1422883 us  
  __wake_up                            19318    121496.0 us     6.289 us        54037.07 us 
  tick_nohz_idle_enter                   394    119544.0 us     303.411 us      24204.73 us 
  proc_fill_cache                        402    119333.0 us     296.848 us      32614.19 us 
  unix_dgram_sendmsg                     144    119088.0 us     827.000 us      197140.4 us 
  enqueue_hrtimer                      99205    118756.0 us     1.197 us        1634.105 us 
  call_usermodehelper_exec_async          12    117852.0 us     9821.000 us     319067.4 us 
  mutex_lock                           14089    117414.0 us     8.333 us        245056.5 us 
  sock_recvmsg                           548    116787.0 us     213.114 us      20249.99 us 
  __smsc95xx_read_reg                     87    116418.0 us     1338.137 us     39000.81 us 
  usbnet_read_cmd                         87    115523.0 us     1327.850 us     37075.87 us 
  SyS_epoll_wait                         336    114271.0 us     340.092 us      47629.77 us 
  __close_fd                            1977    113569.0 us     57.445 us       3969.846 us 
  split_vma                              501    112236.0 us     224.023 us      20703.73 us 
  vma_link                              1248    111097.0 us     89.020 us       5058.706 us 
  __usbnet_read_cmd                       87    111024.0 us     1276.137 us     34288.14 us 
  schedule_hrtimeout_range               390    107480.0 us     275.589 us      10798.57 us 
  dentry_unlink_inode                    733    107440.0 us     146.575 us      8915.389 us 
  unix_find_other                        172    106799.0 us     620.924 us      79499.41 us 
  iput                                   757    106445.0 us     140.614 us      8828.710 us 
  ext4_htree_fill_tree                    36    106438.0 us     2956.611 us     10423331 us 
  kernfs_fop_read                        198    105215.0 us     531.388 us      48887.87 us 
  htree_dirblock_to_tree                  36    104352.0 us     2898.666 us     10008360 us 
  schedule_hrtimeout_range_clock         390    103931.0 us     266.489 us      10595.17 us 
  SyS_connect                             99    102476.0 us     1035.111 us     160650.8 us 
  __mark_inode_dirty                     641    102069.0 us     159.234 us      35047.69 us 
  expire_timers                          700    100145.0 us     143.064 us      8519.548 us 
  do_wait                                 42    99498.00 us     2369.000 us     11701021 us 
  lookup_slow                            413    99137.00 us     240.041 us      40034.02 us 
  release_task                            29    98995.00 us     3413.620 us     12343735 us 
  SyS_fstat64                           1168    98993.00 us     84.754 us       5326.254 us 
  wait_consider_task                     444    98839.00 us     222.610 us      1532328 us  
  kmem_cache_free                      17783    98715.00 us     5.551 us        72804.30 us

...
