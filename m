From: balbi@ti.com (Felipe Balbi)
Date: Fri, 23 Jan 2015 13:51:28 -0600
Subject: perf not capturing stack traces
Message-ID: <20150123195128.GE26557@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm using v3.19-rc5 on an ARM Cortex A9 board. Unfortunately, perf is
not able to capture any stack traces even though I CONFIG_STACKTRACE,
CONFIG_FRAME_POINTER and CONFIG_ARM_UNWIND all enabled.

I wonder if anybody else is facing similar issues.

Here's console grab:

perf record -e 'sched:*' -ag sleep 5  && perf report --stdio
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.092 MB perf.data (~4024 samples) ]
# To display the perf.data header info, please use --header/--header-only option
#
# Samples: 0  of event 'sched:sched_kthread_stop'
# Event count (approx.): 0
#
# Children      Self  Command  Shared Object  Symbol
# ........  ........  .......  .............  ......
#


# Samples: 0  of event 'sched:sched_kthread_stop_ret'
# Event count (approx.): 0
#
# Children      Self  Command  Shared Object  Symbol
# ........  ........  .......  .............  ......
#


# Samples: 62  of event 'sched:sched_wakeup'
# Event count (approx.): 62
#
# Children      Self  Command      Shared Object  Symbol        
# ........  ........  ...........  .............  ..............
:#
    74.19%    74.19%  swapper      [unknown]      [.] 00000000  
                |
                ---0

    11.29%    11.29%  kworker/0:2  [unknown]      [.] 00000000  
            |
            ---0

     9.68%     9.68%  perf         [unknown]      [.] 00000000  
                   |
                   ---0

     3.23%     3.23%  sleep        [unknown]      [.] 00000000  
                  |
                  ---0

     1.61%     1.61%  ksoftirqd/0  [unknown]      [.] 00000000  
            |
            ---0



:# Samples: 0  of event 'sched:sched_wakeup_new'
# Event count (approx.): 0
#
# Children      Self  Command  Shared Object  Symbol
# ........  ........  .......  .............  ......
#


# Samples: 102  of event 'sched:sched_switch'
# Event count (approx.): 102
#
# Children      Self  Command       Shared Object  Symbol        
# ........  ........  ............  .............  ..............
#
    31.37%    31.37%  swapper       [unknown]      [.] 00000000  
                 |
                 ---0

    20.59%    20.59%  kworker/0:2   [unknown]      [.] 00000000  
             |
             ---0

    15.69%    15.69%  ksoftirqd/0   [unknown]      [.] 00000000  
:             |
             ---0

    11.76%    11.76%  perf          [unknown]      [.] 00000000  
                    |
                    ---0

    11.76%    11.76%  sleep         [unknown]      [.] 00000000  
                   |
                   ---0

     7.84%     7.84%  rcu_sched     [unknown]      [.] 00000000  
               |
               ---0

     0.98%     0.98%  kworker/u2:1  [unknown]      [.] 00000000  
            |
            ---0



# Samples: 0  of event 'sched:sched_migrate_task'
# Event count (approx.): 0
:#
# Children      Self  Command  Shared Object  Symbol
# ........  ........  .......  .............  ......
#


# Samples: 0  of event 'sched:sched_process_free'
# Event count (approx.): 0
#
# Children      Self  Command  Shared Object  Symbol
# ........  ........  .......  .............  ......
#


# Samples: 1  of event 'sched:sched_process_exit'
# Event count (approx.): 1
#
# Children      Self  Command  Shared Object  Symbol        
# ........  ........  .......  .............  ..............
#
   100.00%   100.00%  sleep    [unknown]      [.] 00000000  
              |
              ---0
:


# Samples: 0  of event 'sched:sched_wait_task'
# Event count (approx.): 0
#
# Children      Self  Command  Shared Object  Symbol
# ........  ........  .......  .............  ......
#


# Samples: 0  of event 'sched:sched_process_wait'
# Event count (approx.): 0
#
# Children      Self  Command  Shared Object  Symbol
# ........  ........  .......  .............  ......
#


# Samples: 0  of event 'sched:sched_process_fork'
# Event count (approx.): 0
#
# Children      Self  Command  Shared Object  Symbol
:# ........  ........  .......  .............  ......
#


# Samples: 1  of event 'sched:sched_process_exec'
# Event count (approx.): 1
#
# Children      Self  Command  Shared Object  Symbol        
# ........  ........  .......  .............  ..............
#
   100.00%   100.00%  sleep    [unknown]      [.] 00000000  
              |
              ---0



# Samples: 70  of event 'sched:sched_stat_wait'
# Event count (approx.): 17926123
#
# Children      Self  Command      Shared Object  Symbol        
# ........  ........  ...........  .............  ..............
#
    33.13%    33.13%  ksoftirqd/0  [unknown]      [.] 00000000  
:            |
            ---0

    24.83%    24.83%  perf         [unknown]      [.] 00000000  
                   |
                   ---0

    21.44%    21.44%  sleep        [unknown]      [.] 00000000  
                  |
                  ---0

    20.60%    20.60%  rcu_sched    [unknown]      [.] 00000000  
              |
              ---0

     0.00%     0.00%  kworker/0:2  [unknown]      [.] 00000000  
            |
            ---0

     0.00%     0.00%  swapper      [unknown]      [.] 00000000  
                |
                ---0

:

# Samples: 43  of event 'sched:sched_stat_sleep'
# Event count (approx.): 119659990589
#
# Children      Self  Command  Shared Object  Symbol        
# ........  ........  .......  .............  ..............
#
    95.01%    95.01%  swapper  [unknown]      [.] 00000000  
            |
            ---0

     4.93%     4.93%  sleep    [unknown]      [.] 00000000  
              |
              ---0

     0.06%     0.06%  perf     [unknown]      [.] 00000000  
               |
               ---0



# Samples: 7  of event 'sched:sched_stat_iowait'
:# Event count (approx.): 37447751
#
# Children      Self  Command      Shared Object  Symbol        
# ........  ........  ...........  .............  ..............
#
   100.00%   100.00%  kworker/0:2  [unknown]      [.] 00000000  
            |
            ---0



# Samples: 19  of event 'sched:sched_stat_blocked'
# Event count (approx.): 42514750
#
# Children      Self  Command      Shared Object  Symbol        
# ........  ........  ...........  .............  ..............
#
    88.08%    88.08%  kworker/0:2  [unknown]      [.] 00000000  
            |
            ---0

     7.24%     7.24%  swapper      [unknown]      [.] 00000000  
                |
:                ---0

     3.81%     3.81%  ksoftirqd/0  [unknown]      [.] 00000000  
            |
            ---0

     0.86%     0.86%  perf         [unknown]      [.] 00000000  
                   |
                   ---0



# Samples: 79  of event 'sched:sched_stat_runtime'
# Event count (approx.): 46820375
#
# Children      Self  Command       Shared Object  Symbol        
# ........  ........  ............  .............  ..............
#
    27.85%    27.85%  perf          [unknown]      [.] 00000000  
                    |
                    ---0

    27.48%    27.48%  kworker/0:2   [unknown]      [.] 00000000  
:             |
             ---0

    20.79%    20.79%  sleep         [unknown]      [.] 00000000  
                   |
                   ---0

    12.51%    12.51%  ksoftirqd/0   [unknown]      [.] 00000000  
             |
             ---0

     8.96%     8.96%  rcu_sched     [unknown]      [.] 00000000  
               |
               ---0

     2.41%     2.41%  kworker/u2:1  [unknown]      [.] 00000000  
            |
            ---0



# Samples: 0  of event 'sched:sched_pi_setprio'
# Event count (approx.): 0
:#
# Children      Self  Command  Shared Object  Symbol
# ........  ........  .......  .............  ......
#


# Samples: 0  of event 'sched:sched_move_numa'
# Event count (approx.): 0
#
# Children      Self  Command  Shared Object  Symbol
# ........  ........  .......  .............  ......
#


# Samples: 0  of event 'sched:sched_stick_numa'
# Event count (approx.): 0
#
# Children      Self  Command  Shared Object  Symbol
# ........  ........  .......  .............  ......
#


# Samples: 0  of event 'sched:sched_swap_numa'
:# Event count (approx.): 0
#
# Children      Self  Command  Shared Object  Symbol
# ........  ........  .......  .............  ......
#


# Samples: 0  of event 'sched:sched_wake_idle_without_ipi'
# Event count (approx.): 0
#
# Children      Self  Command  Shared Object  Symbol
# ........  ........  .......  .............  ......
#

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150123/8cc673a6/attachment-0001.sig>
