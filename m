From: ttnguyen@apm.com (Tai Tri Nguyen)
Date: Thu, 12 Apr 2018 10:49:49 -0700
Subject: [bug report] locking/qrwlock, arm64: Move rwlock implementation
 over to qrwlocks causes CPU crashes/stalls when killing java processes
In-Reply-To: <20180412172456.GA27033@arm.com>
References: <CACgAJHzeS7CNqLaVckNtS5BNTsqe0ac+u0LwJAr1_1i1=OLcnA@mail.gmail.com>
 <20180412172456.GA27033@arm.com>
Message-ID: <CACgAJHz9_JKdO9bn1fiPURNq5S4XGeVNnBKx79JhM7Hcp-Tf-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Somehow so far I only see the issue when killing Java processes.
Here is the log. It's a bit long.
I'll try removing wfe as you suggested.

[ 2499.459849] INFO: rcu_sched self-detected stall on CPU
[ 2499.459851] INFO: rcu_sched self-detected stall on CPU
[ 2499.459855] INFO: rcu_sched self-detected stall on CPU

[ 2499.459856] INFO: rcu_sched self-detected stall on CPU

[ 2499.459858] INFO: rcu_sched self-detected stall on CPU

[ 2499.459861]  1-...!: (11 GPs behind) idle=dee/140000000000001/0
softirq=40890/40890 fqs=0

[ 2499.459862] INFO: rcu_sched self-detected stall on CPU

[ 2499.459864] INFO: rcu_sched self-detected stall on CPU

[ 2499.459866] INFO: rcu_sched self-detected stall on CPU

[ 2499.459866]
[ 2499.459870]  14-...!: (1 GPs behind) idle=a9e/140000000000001/0
softirq=42949/42950 fqs=0
[ 2499.459871] INFO: rcu_sched self-detected stall on CPU
[ 2499.459873] INFO: rcu_sched self-detected stall on CPU
[ 2499.459876] INFO: rcu_sched self-detected stall on CPU
[ 2499.459878] INFO: rcu_sched self-detected stall on CPU
[ 2499.459881] INFO: rcu_sched self-detected stall on CPU
[ 2499.459882]  (t=60744 jiffies g=20044 c=20043 q=4496)
[ 2499.459884] INFO: rcu_sched self-detected stall on CPU
[ 2499.459885] INFO: rcu_sched self-detected stall on CPU
[ 2499.459886]
[ 2499.459890]  0-...!: (11 GPs behind) idle=70a/140000000000001/0
softirq=44883/44883 fqs=0
[ 2499.459891] INFO: rcu_sched self-detected stall on CPU
[ 2499.459893] INFO: rcu_sched self-detected stall on CPU
[ 2499.459896] INFO: rcu_sched self-detected stall on CPU
[ 2499.459898] INFO: rcu_sched self-detected stall on CPU
[ 2499.459899] INFO: rcu_sched self-detected stall on CPU
[ 2499.459901] INFO: rcu_sched self-detected stall on CPU
[ 2499.459903] INFO: rcu_sched self-detected stall on CPU
[ 2499.459906] INFO: rcu_sched self-detected stall on CPU
[ 2499.459907] INFO: rcu_sched self-detected stall on CPU
[ 2499.459909] INFO: rcu_sched self-detected stall on CPU
[ 2499.459910] INFO: rcu_sched self-detected stall on CPU
[ 2499.459914] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=16
[ 2499.459916]  (t=60744 jiffies g=20044 c=20043 q=4506)
[ 2499.459916]
[ 2499.459920]  6-...!: (2 GPs behind) idle=e0a/140000000000001/0
softirq=42006/42006 fqs=0
[ 2499.459924]  31-...!: (8 GPs behind) idle=6fe/140000000000001/0
softirq=39495/39495 fqs=0
[ 2499.459928] rcu_sched       I
[ 2499.459930] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=16
[ 2499.459932]  (t=60744 jiffies g=20044 c=20043 q=4518)
[ 2499.459932]
[ 2499.459935]  12-...!: (48 GPs behind) idle=37a/140000000000001/0
softirq=41640/41640 fqs=0
[ 2499.459936]
[ 2499.459939]  21-...!: (49 GPs behind) idle=d92/140000000000001/0
softirq=39863/39863 fqs=0
[ 2499.459940]     0     8      2 0x00000000
[ 2499.459941] rcu_sched       I
[ 2499.459943] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=16
[ 2499.459945]  (t=60744 jiffies g=20044 c=20043 q=4524)
[ 2499.459945]
[ 2499.459948]  13-...!: (24 GPs behind) idle=782/140000000000001/0
softirq=41666/41666 fqs=0
[ 2499.459949]  (t=60744 jiffies g=20044 c=20043 q=4526)
[ 2499.459950]
[ 2499.459954]  29-...!: (11 GPs behind) idle=39e/140000000000001/0
softirq=40806/40806 fqs=0
[ 2499.459955] Call trace:
[ 2499.459956]     0     8      2 0x00000000
[ 2499.459957] rcu_sched       I
[ 2499.459959] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=16
[ 2499.459960]  (t=60744 jiffies g=20044 c=20043 q=4532)
[ 2499.459961]
[ 2499.459964]  4-...!: (9 GPs behind) idle=e4a/140000000000001/0
softirq=42001/42001 fqs=0
[ 2499.459966] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=16
[ 2499.459967]  (t=60744 jiffies g=20044 c=20043 q=4536)
[ 2499.459968]
[ 2499.459971]  23-...!: (2 GPs behind) idle=612/140000000000001/0
softirq=39387/39387 fqs=0
[ 2499.459978]  __switch_to+0x8c/0xa8
[ 2499.459978] Call trace:
[ 2499.459980]     0     8      2 0x00000000
[ 2499.459980] rcu_sched       I
[ 2499.459983] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=16
[ 2499.459984]  (t=60744 jiffies g=20044 c=20043 q=4542)
[ 2499.459984]
[ 2499.459988]  15-...!: (1 GPs behind) idle=3ea/140000000000001/0
softirq=42324/42325 fqs=0
[ 2499.459988] rcu_sched       I
[ 2499.459991] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=16
[ 2499.459992]  (t=60744 jiffies g=20044 c=20043 q=4546)
[ 2499.459993]
[ 2499.459996]  30-...!: (8 GPs behind) idle=20e/140000000000001/0
softirq=39663/39663 fqs=0
[ 2499.460000]  __schedule+0x308/0x780
[ 2499.460003]  __switch_to+0x8c/0xa8
[ 2499.460004] Call trace:
[ 2499.460005]     0     8      2 0x00000000
[ 2499.460006] rcu_sched       I
[ 2499.460008] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=16
[ 2499.460010]  (t=60744 jiffies g=20044 c=20043 q=4554)
[ 2499.460010]
[ 2499.460014]  10-...!: (44 GPs behind) idle=e9a/140000000000001/0
softirq=40602/40602 fqs=0
[ 2499.460015]     0     8      2 0x00000000
[ 2499.460016] rcu_sched       I
[ 2499.460019] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=16
[ 2499.460020]  (t=60744 jiffies g=20044 c=20043 q=4554)
[ 2499.460021]
[ 2499.460024]  19-...!: (48 GPs behind) idle=66e/140000000000001/0
softirq=40256/40256 fqs=0
[ 2499.460026]  schedule+0x2c/0x84
[ 2499.460028]  __schedule+0x308/0x780
[ 2499.460030]  __switch_to+0x8c/0xa8
[ 2499.460031] Call trace:
[ 2499.460033]     0     8      2 0x00000000
[ 2499.460033] rcu_sched       I
[ 2499.460036] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=16
[ 2499.460038]  (t=60744 jiffies g=20044 c=20043 q=4564)
[ 2499.460038]
[ 2499.460042]  3-...!: (2 GPs behind) idle=a72/140000000000001/0
softirq=42939/42939 fqs=0
[ 2499.460043] Call trace:
[ 2499.460044]     0     8      2 0x00000000
[ 2499.460045] rcu_sched       I
[ 2499.460048] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=16
[ 2499.460050]  (t=60744 jiffies g=20044 c=20043 q=4572)
[ 2499.460050]
[ 2499.460054]  24-...!: (1 GPs behind) idle=96e/140000000000001/0
softirq=44352/44352 fqs=0
[ 2499.460056]  schedule_timeout+0x17c/0x340
[ 2499.460058]  schedule+0x2c/0x84
[ 2499.460060]  __schedule+0x308/0x780
[ 2499.460064]  __switch_to+0x8c/0xa8
[ 2499.460064] Call trace:
[ 2499.460066]     0     8      2 0x00000000
[ 2499.460067] rcu_sched       I
[ 2499.460070] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=16
[ 2499.460071]  (t=60744 jiffies g=20044 c=20043 q=4583)
[ 2499.460072]
[ 2499.460075]  8-...!: (17 GPs behind) idle=b66/140000000000001/0
softirq=41327/41327 fqs=0
[ 2499.460079]  __switch_to+0x8c/0xa8
[ 2499.460080] Call trace:
[ 2499.460082]     0     8      2 0x00000000
[ 2499.460083] rcu_sched       I
[ 2499.460085] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=16
[ 2499.460087]  (t=60744 jiffies g=20044 c=20043 q=4591)
[ 2499.460088]
[ 2499.460092]  16-...!: (1 ticks this GP) idle=4ce/140000000000001/0
softirq=42162/42162 fqs=0
[ 2499.460095]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460096]  schedule_timeout+0x17c/0x340
[ 2499.460098]  schedule+0x2c/0x84
[ 2499.460100]  __schedule+0x308/0x780
[ 2499.460104]  __switch_to+0x8c/0xa8
[ 2499.460105] Call trace:
[ 2499.460106]     0     8      2 0x00000000
[ 2499.460107] rcu_sched       I
[ 2499.460110] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=16
[ 2499.460111]  (t=60744 jiffies g=20044 c=20043 q=4593)
[ 2499.460112]
[ 2499.460115]  7-...!: (4 GPs behind) idle=a86/140000000000001/0
softirq=42408/42408 fqs=0
[ 2499.460118]  __schedule+0x308/0x780
[ 2499.460122]  __switch_to+0x8c/0xa8
[ 2499.460123] Call trace:
[ 2499.460125]     0     8      2 0x00000000
[ 2499.460126] rcu_sched       I
[ 2499.460129] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=16
[ 2499.460131]  (t=60744 jiffies g=20044 c=20043 q=4601)
[ 2499.460131]
[ 2499.460135]  17-...!: (9 GPs behind) idle=3ea/140000000000001/0
softirq=41372/41372 fqs=0
[ 2499.460137]  kthread+0xfc/0x128
[ 2499.460139]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460140]  schedule_timeout+0x17c/0x340
[ 2499.460142]  schedule+0x2c/0x84
[ 2499.460145]  __schedule+0x308/0x780
[ 2499.460147]  __switch_to+0x8c/0xa8
[ 2499.460148] Call trace:
[ 2499.460150]     0     8      2 0x00000000
[ 2499.460150] rcu_sched       I
[ 2499.460153] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=16
[ 2499.460155]  (t=60744 jiffies g=20044 c=20043 q=4615)
[ 2499.460155]
[ 2499.460159]  5-...!: (6 GPs behind) idle=03e/140000000000001/0
softirq=42897/42897 fqs=0
[ 2499.460160]  schedule+0x2c/0x84
[ 2499.460163]  __schedule+0x308/0x780
[ 2499.460167]  __switch_to+0x8c/0xa8
[ 2499.460168] Call trace:
[ 2499.460170]     0     8      2 0x00000000
[ 2499.460171] rcu_sched       I
[ 2499.460174] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=16
[ 2499.460176]  (t=60744 jiffies g=20044 c=20043 q=4625)
[ 2499.460176]
[ 2499.460180]  27-...!: (24 GPs behind) idle=48e/140000000000001/0
softirq=41609/41609 fqs=0
[ 2499.460182]  ret_from_fork+0x10/0x18
[ 2499.460184]  kthread+0xfc/0x128
[ 2499.460185]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460187]  schedule_timeout+0x17c/0x340
[ 2499.460189]  schedule+0x2c/0x84
[ 2499.460190]  __schedule+0x308/0x780
[ 2499.460194]  __switch_to+0x8c/0xa8
[ 2499.460195] Call trace:
[ 2499.460197]     0     8      2 0x00000000
[ 2499.460198] rcu_sched       I
[ 2499.460200] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=16
[ 2499.460202]  (t=60744 jiffies g=20044 c=20043 q=4631)
[ 2499.460202]
[ 2499.460206]  9-...!: (44 GPs behind) idle=cf2/140000000000001/0
softirq=42607/42607 fqs=0
[ 2499.460208]  schedule_timeout+0x17c/0x340
[ 2499.460209]  schedule+0x2c/0x84
[ 2499.460212]  __schedule+0x308/0x780
[ 2499.460217]  __switch_to+0x8c/0xa8
[ 2499.460217] Call trace:
[ 2499.460219]     0     8      2 0x00000000
[ 2499.460221] rcu_sched       I
[ 2499.460223] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=16
[ 2499.460225]  (t=60744 jiffies g=20044 c=20043 q=4642)
[ 2499.460226]
[ 2499.460230]  20-...!: (45 GPs behind) idle=7d6/140000000000001/0
softirq=41898/41898 fqs=0
[ 2499.460231]  ret_from_fork+0x10/0x18
[ 2499.460233]  kthread+0xfc/0x128
[ 2499.460235]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460236]  schedule_timeout+0x17c/0x340
[ 2499.460238]  schedule+0x2c/0x84
[ 2499.460240]  __schedule+0x308/0x780
[ 2499.460243]  __switch_to+0x8c/0xa8
[ 2499.460244] Call trace:
[ 2499.460245]     0     8      2 0x00000000
[ 2499.460246] rcu_sched       R
[ 2499.460249] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x200 ->cpu=16
[ 2499.460251]  (t=60744 jiffies g=20044 c=20043 q=4658)
[ 2499.460251]
[ 2499.460253] Task dump for CPU 0:
[ 2499.460255]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460257]  schedule_timeout+0x17c/0x340
2449[ 2499.460259]  schedule+0x2c/0x84

[ 2499.460262]  __schedule+0x308/0x780
[ 2499.460264]  __switch_to+0x8c/0xa8
[ 2499.460265] Call trace:
[ 2499.460267]     0     8      2 0x00000000
[ 2499.460268] rcu_sched       R
[ 2499.460271] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x200 ->cpu=16
[ 2499.460272]  (t=60744 jiffies g=20044 c=20043 q=4669)
[ 2499.460273]
[ 2499.460275]  ret_from_fork+0x10/0x18
[ 2499.460277]  kthread+0xfc/0x128
[ 2499.460279]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460280]  schedule_timeout+0x17c/0x340
[ 2499.460282]  schedule+0x2c/0x84
[ 2499.460284]  __schedule+0x308/0x780
[ 2499.460287]  __switch_to+0x8c/0xa8
[ 2499.460288] Call trace:
[ 2499.460290]     0     8      2 0x00000000
[ 2499.460291] rcu_sched       R
[ 2499.460293] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x200 ->cpu=16
[root at hadoop-slave-1 scripts]# [ 2499.460295]  (t=60744 jiffies
g=20044 c=20043 q=4687)
[ 2499.460296] java            X
[ 2499.460298]  kthread+0xfc/0x128

[ 2499.460300]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460302]  schedule_timeout+0x17c/0x340
[ 2499.460304]  schedule+0x2c/0x84
[ 2499.460306]  __schedule+0x308/0x780
[ 2499.460310]  __switch_to+0x8c/0xa8
[root at hadoop-slave-1 scripts]# [ 2499.460311] Call trace:
[ 2499.460312]     0     8      2 0x00000000
[ 2499.460313] rcu_sched       R

[ 2499.460317] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x200 ->cpu=16
[ 2499.460318]  (t=60744 jiffies g=20044 c=20043 q=4703)
[ 2499.460320]  ret_from_fork+0x10/0x18
[ 2499.460322]  kthread+0xfc/0x128
[ 2499.460323]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460324]  schedule_timeout+0x17c/0x340
[ 2499.460326]  schedule+0x2c/0x84
[ 2499.460328]  __schedule+0x308/0x780
[ 2499.460332]  __switch_to+0x8c/0xa8
[ 2499.460333] Call trace:
[ 2499.460334]     0     8      2 0x00000000
[ 2499.460335] rcu_sched       R
[ 2499.460338] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x200 ->cpu=16
[ 2499.460338]   running task
[ 2499.460341]  ret_from_fork+0x10/0x18
[ 2499.460342]  kthread+0xfc/0x128
[ 2499.460345]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460347]  schedule_timeout+0x17c/0x340
[root at hadoop-slave-1 scripts]# [ 2499.460349]  schedule+0x2c/0x84
[ 2499.460351]  __schedule+0x308/0x780
[ 2499.460355]  __switch_to+0x8c/0xa8

[ 2499.460356] Call trace:
[ 2499.460358]     0     8      2 0x00000000
[ 2499.460359] rcu_sched       R
[ 2499.460362] rcu_sched kthread starved for 60744 jiffies! g20044
c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x200 ->cpu=16
[ 2499.460363]  ret_from_fork+0x10/0x18
[root at hadoop-slave-1 scripts]# [ 2499.460365]  kthread+0xfc/0x128
[ 2499.460366]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460368]  schedule_timeout+0x17c/0x340

[ 2499.460370]  schedule+0x2c/0x84
[ 2499.460373]  __switch_to+0x8c/0xa8
[ 2499.460376]  __schedule+0x308/0x780
[ 2499.460377] Call trace:
[ 2499.460378]     0     8      2 0x00000000
[ 2499.460379] rcu_sched       R
[ 2499.460380]     0  6128      1 0x00000229
[ 2499.460382]  ret_from_fork+0x10/0x18
[ 2499.460384]  kthread+0xfc/0x128
[ 2499.460386]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460388]  schedule_timeout+0x17c/0x340
[ 2499.460390]  schedule+0x2c/0x84
[ 2499.460392]  __schedule+0x308/0x780
[ 2499.460396]  __switch_to+0x8c/0xa8
[ 2499.460397] Call trace:
[ 2499.460399]     0     8      2 0x00000000
[ 2499.460400] rcu_sched       R
[ 2499.460402]  ret_from_fork+0x10/0x18
[ 2499.460404]  kthread+0xfc/0x128
[ 2499.460405]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460407]  schedule_timeout+0x17c/0x340
[ 2499.460409]  __schedule+0x308/0x780
[ 2499.460411]  schedule+0x2c/0x84
[root at hadoop-slave-1 scripts]# [ 2499.460414]  __switch_to+0x8c/0xa8
[ 2499.460415] Call trace:
[ 2499.460416]     0     8      2 0x00000000
[ 2499.460417] Call trace:

[ 2499.460419]  ret_from_fork+0x10/0x18
[ 2499.460421]  kthread+0xfc/0x128
[ 2499.460423]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460425]  schedule_timeout+0x17c/0x340
[ 2499.460427]  schedule+0x2c/0x84
[root at hadoop-slave-1 scripts]# [ 2499.460429]  __schedule+0x308/0x780
[ 2499.460431]  __switch_to+0x8c/0xa8
[ 2499.460432] Call trace:

[ 2499.460434]     0     8      2 0x00000000
[ 2499.460435]  ret_from_fork+0x10/0x18
[ 2499.460437]  kthread+0xfc/0x128
[ 2499.460438]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460440]  schedule+0x2c/0x84
[root at hadoop-slave-1 scripts]# [ 2499.460442]  schedule_timeout+0x17c/0x340
[ 2499.460443]  __schedule+0x308/0x780
[ 2499.460446]  __switch_to+0x8c/0xa8

[ 2499.460447] Call trace:
[ 2499.460448]  __switch_to+0x8c/0xa8
[ 2499.460451]  ret_from_fork+0x10/0x18
[ 2499.460452]  kthread+0xfc/0x128
[ 2499.460454]  rcu_gp_kthread+0x3a8/0x7c0
[root at hadoop-slave-1 scripts]# [ 2499.460456]  schedule_timeout+0x17c/0x340
[ 2499.460458]  schedule+0x2c/0x84
[ 2499.460460]  __schedule+0x308/0x780
[ 2499.460463]  __switch_to+0x8c/0xa8
[ 2499.460464] Call trace:
[ 2499.460466]  ret_from_fork+0x10/0x18
[ 2499.460467]  kthread+0xfc/0x128
[ 2499.460469]  schedule_timeout+0x17c/0x340
[ 2499.460471]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460472]  schedule+0x2c/0x84
[ 2499.460474]  __schedule+0x308/0x780
[ 2499.460477]  __switch_to+0x8c/0xa8
[ 2499.460479]  set_next_entity+0x3b0/0x5f8
[ 2499.460480]  ret_from_fork+0x10/0x18
[ 2499.460482]  kthread+0xfc/0x128
[ 2499.460484]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460486]  schedule_timeout+0x17c/0x340
[ 2499.460487]  schedule+0x2c/0x84
[ 2499.460489]  __schedule+0x308/0x780
[ 2499.460492]  __switch_to+0x8c/0xa8
[ 2499.460493]  ret_from_fork+0x10/0x18
[ 2499.460495]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460497]  kthread+0xfc/0x128
[ 2499.460498]  schedule_timeout+0x17c/0x340
[ 2499.460499]  schedule+0x2c/0x84
[ 2499.460501]  __schedule+0x308/0x780
[ 2499.460503]  0x33
[ 2499.460505]  ret_from_fork+0x10/0x18
[ 2499.460506]  kthread+0xfc/0x128
[ 2499.460508]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460509]  schedule_timeout+0x17c/0x340
[ 2499.460511]  schedule+0x2c/0x84
[ 2499.460513]  __schedule+0x308/0x780
[ 2499.460514]  kthread+0xfc/0x128
[ 2499.460516]  ret_from_fork+0x10/0x18
[ 2499.460517]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460518]  schedule_timeout+0x17c/0x340
[ 2499.460520]  schedule+0x2c/0x84
[ 2499.460520] Task dump for CPU 1:
[ 2499.460523]  ret_from_fork+0x10/0x18
[ 2499.460524]  kthread+0xfc/0x128
[ 2499.460525]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460527]  schedule_timeout+0x17c/0x340
[ 2499.460528]  schedule+0x2c/0x84
[ 2499.460529]  ret_from_fork+0x10/0x18
[ 2499.460531]  kthread+0xfc/0x128
[ 2499.460532]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460533]  schedule_timeout+0x17c/0x340
[ 2499.460534] java            X
[ 2499.460535]  ret_from_fork+0x10/0x18
[ 2499.460536]  kthread+0xfc/0x128
[ 2499.460538]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460539]  schedule_timeout+0x17c/0x340
[ 2499.460541]  ret_from_fork+0x10/0x18
[ 2499.460542]  kthread+0xfc/0x128
[ 2499.460544]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460544]   running task
[ 2499.460545]  ret_from_fork+0x10/0x18
[ 2499.460547]  kthread+0xfc/0x128
[ 2499.460548]  rcu_gp_kthread+0x3a8/0x7c0
[ 2499.460550]  ret_from_fork+0x10/0x18
[ 2499.460551]  kthread+0xfc/0x128
[ 2499.460552]     0  4461      0 0x00000228
[ 2499.460553]  ret_from_fork+0x10/0x18
[ 2499.460554]  kthread+0xfc/0x128
[ 2499.460555]  ret_from_fork+0x10/0x18
[ 2499.460556] Call trace:
[ 2499.460557]  ret_from_fork+0x10/0x18
[ 2499.460559]  dump_backtrace+0x0/0x178
[ 2499.460560]  show_stack+0x14/0x1c
[ 2499.460562]  sched_show_task+0x120/0x138
[ 2499.460564]  dump_cpu_task+0x40/0x4c
[ 2499.460565]  rcu_dump_cpu_stacks+0xa4/0xe4
[ 2499.460567]  rcu_check_callbacks+0x760/0x970
[ 2499.460569]  update_process_times+0x2c/0x54
[ 2499.460571]  tick_sched_handle.isra.13+0x34/0x54
[ 2499.460573]  tick_sched_timer+0x40/0x80
[ 2499.460574]  __hrtimer_run_queues+0xdc/0x130
[ 2499.460575]  hrtimer_interrupt+0x98/0x1cc
[ 2499.460578]  arch_timer_handler_phys+0x2c/0x38
[ 2499.460580]  handle_percpu_devid_irq+0x78/0x120
[ 2499.460582]  generic_handle_irq+0x24/0x38
[ 2499.460584]  __handle_domain_irq+0x60/0xb4
[ 2499.460585]  gic_handle_irq+0x98/0x1b0
[ 2499.460586]  el1_irq+0xb0/0x140
[ 2499.460588]  release_task+0x374/0x520
[ 2499.460589]  do_exit+0x50c/0x9d0
[ 2499.460590]  do_group_exit+0x38/0xa0
[ 2499.460592]  get_signal+0x13c/0x444
[ 2499.460593]  do_signal+0x68/0x1c0
[ 2499.460595]  do_notify_resume+0xcc/0x10c
[ 2499.460596]  work_pending+0x8/0x10
[ 2499.460597] Task dump for CPU 2:
[ 2499.460597] x2gocleansessio R  running task        0 14810   1402 0x00000220
[ 2499.460599] Call trace:
[ 2499.460601]  ret_from_fork+0x0/0x18
[ 2499.460601] Task dump for CPU 3:
[ 2499.460602] java            X  running task        0  7041      0 0x0000022a
[ 2499.460604] Call trace:
[ 2499.460605]  __switch_to+0x8c/0xa8
[ 2499.460606]  0xe
[ 2499.460606] Task dump for CPU 4:
[ 2499.460607] java            X  running task        0  4660      0 0x00000228
[ 2499.460609] Call trace:
[ 2499.460610]  __switch_to+0x8c/0xa8
[ 2499.460611]  0xe
[ 2499.460611] Task dump for CPU 5:
[ 2499.460612] java            X  running task        0  4546      1 0x00000229
[ 2499.460614] Call trace:
[ 2499.460615]  __switch_to+0x8c/0xa8
[ 2499.460616]  set_next_entity+0x3b0/0x5f8
[ 2499.460617]  0x33
[ 2499.460618] Task dump for CPU 6:
[ 2499.460618] java            X  running task        0  4755      1 0x00000229
[ 2499.460620] Call trace:
[ 2499.460621]  __switch_to+0x8c/0xa8
[ 2499.460623]  set_next_entity+0x3b0/0x5f8
[ 2499.460623]  0x33
[ 2499.460624] Task dump for CPU 7:
[ 2499.460625] java            X  running task        0  4529      1 0x00000229
[ 2499.460626] Call trace:
[ 2499.460628]  __switch_to+0x8c/0xa8
[ 2499.460629]  set_next_entity+0x3b0/0x5f8
[ 2499.460630]  0x33
[ 2499.460630] Task dump for CPU 8:
[ 2499.460631] java            X  running task        0  4577      1 0x00000229
[ 2499.460633] Call trace:
[ 2499.460634]  __switch_to+0x8c/0xa8
[ 2499.460635]  set_next_entity+0x3b0/0x5f8
[ 2499.460636]  0x33
[ 2499.460636] Task dump for CPU 9:
[ 2499.460637] java            X  running task        0  6979      1 0x00000229
[ 2499.460638] Call trace:
[ 2499.460640]  __switch_to+0x8c/0xa8
[ 2499.460641]  set_next_entity+0x3b0/0x5f8
[ 2499.460642]  0x33
[ 2499.460642] Task dump for CPU 10:
[ 2499.460643] stop-cassandra. S    0 14808  14764 0x00000208
[ 2499.460644] Call trace:
[ 2499.460646]  __switch_to+0x8c/0xa8
[ 2499.460646]  0xffff00004bd2fd90
[ 2499.460647] Task dump for CPU 11:
[ 2499.460648] java            X  running task        0  2496      1 0x00000229
[ 2499.460649] Call trace:
[ 2499.460651]  __switch_to+0x8c/0xa8
[ 2499.460652]  set_next_entity+0x3b0/0x5f8
[ 2499.460653]  0x33
[ 2499.460653] Task dump for CPU 12:
[ 2499.460654] java            X  running task        0  4586      0 0x00000228
[ 2499.460655] Call trace:
[ 2499.460657]  __switch_to+0x8c/0xa8
[ 2499.460657]  0xe
[ 2499.460658] Task dump for CPU 13:
[ 2499.460659] java            X  running task        0  4572      1 0x00000229
[ 2499.460660] Call trace:
[ 2499.460662]  __switch_to+0x8c/0xa8
[ 2499.460663]  set_next_entity+0x3b0/0x5f8
[ 2499.460663]  0x33
[ 2499.460664] Task dump for CPU 14:
[ 2499.460665] java            X  running task        0 10425      0 0x00000228
[ 2499.460666] Call trace:
[ 2499.460668]  __switch_to+0x8c/0xa8
[ 2499.460668]            (null)
[ 2499.460669]  do_group_exit+0x38/0xa0
[ 2499.460670]  get_signal+0x13c/0x444
[ 2499.460672]  do_signal+0x68/0x1c0
[ 2499.460673]  do_notify_resume+0xcc/0x10c
[ 2499.460674]  work_pending+0x8/0x10
[ 2499.460675] Task dump for CPU 15:
[ 2499.460676] java            X  running task        0  8654      0 0x00000228
[ 2499.460677] Call trace:
[ 2499.460679]  __switch_to+0x8c/0xa8
[ 2499.460679]            (null)
[ 2499.460680]  do_group_exit+0x38/0xa0
[ 2499.460681]  get_signal+0x13c/0x444
[ 2499.460683]  do_signal+0x68/0x1c0
[ 2499.460684]  do_notify_resume+0xcc/0x10c
[ 2499.460685]  work_pending+0x8/0x10
[ 2499.460686] Task dump for CPU 0:
[ 2499.460687] Task dump for CPU 16:
[ 2499.460687] java            X
[ 2499.460688] java            X
[ 2499.460689]   running task
[ 2499.460689]   running task
[ 2499.460690]     0  6128      1 0x00000229
[ 2499.460691]     0  4580      0 0x00000228
[ 2499.460692] Call trace:
[ 2499.460692] Call trace:
[ 2499.460693]  __switch_to+0x8c/0xa8
[ 2499.460695]  __switch_to+0x8c/0xa8
[ 2499.460696]  set_next_entity+0x3b0/0x5f8
[ 2499.460697]  0xe
[ 2499.460698]  0x33
[ 2499.460698] Task dump for CPU 17:
[ 2499.460699] Task dump for CPU 1:
[ 2499.460699] java            X
[ 2499.460700] java            X
[ 2499.460700]   running task
[ 2499.460701]   running task
[ 2499.460702]     0  4538      1 0x00000229
[ 2499.460702]     0  4461      0 0x00000228
[ 2499.460703] Call trace:
[ 2499.460703] Call trace:
[ 2499.460704]  __switch_to+0x8c/0xa8
[ 2499.460706]  __switch_to+0x8c/0xa8
[ 2499.460707]  set_next_entity+0x3b0/0x5f8
[ 2499.460707]  0xe
[ 2499.460708]  0x33
[ 2499.460709] Task dump for CPU 2:
[ 2499.460709] Task dump for CPU 18:
[ 2499.460709] sh              R
[ 2499.460710] abrt-hook-ccpp  R
[ 2499.460711]   running task
[ 2499.460711]   running task
[ 2499.460712]     0 14810   1402 0x00000200
[ 2499.460713]     0 14811      2 0x00000200
[ 2499.460713] Call trace:
[ 2499.460714] Call trace:
[ 2499.460715]  ret_from_fork+0x0/0x18
[ 2499.460716]  ret_from_fork+0x0/0x18
[ 2499.460716] Task dump for CPU 3:
[ 2499.460717] Task dump for CPU 19:
[ 2499.460717] java            X
[ 2499.460718] java            X
[ 2499.460719]   running task
[ 2499.460719]   running task
[ 2499.460720]     0  7041      0 0x0000022a
[ 2499.460721]     0  6708      1 0x00000229
[ 2499.460721] Call trace:
[ 2499.460722] Call trace:
[ 2499.460723]  __switch_to+0x8c/0xa8
[ 2499.460724]  __switch_to+0x8c/0xa8
[ 2499.460725]  0xe
[ 2499.460726]  do_exit+0x2a4/0x9d0
[ 2499.460726] Task dump for CPU 4:
[ 2499.460727]  do_group_exit+0x38/0xa0
[ 2499.460728] java            X
[ 2499.460729]  get_signal+0x13c/0x444
[ 2499.460729]   running task
[ 2499.460731]  do_signal+0x68/0x1c0
[ 2499.460732]     0  4660      0 0x00000228
[ 2499.460733]  do_notify_resume+0xcc/0x10c
[ 2499.460733] Call trace:
[ 2499.460734]  work_pending+0x8/0x10
[ 2499.460736]  __switch_to+0x8c/0xa8
[ 2499.460736] Task dump for CPU 20:
[ 2499.460737]  0xe
[ 2499.460737] java            X
[ 2499.460738] Task dump for CPU 5:
[ 2499.460738]   running task
[ 2499.460739] java            X
[ 2499.460740]     0 10449      1 0x00000221
[ 2499.460740]   running task
[ 2499.460741] Call trace:
[ 2499.460742]     0  4546      1 0x00000229
[ 2499.460743]  __switch_to+0x8c/0xa8
[ 2499.460744] Call trace:
[ 2499.460745]  do_exit+0x2a4/0x9d0
[ 2499.460746]  __switch_to+0x8c/0xa8
[ 2499.460747]  do_group_exit+0x38/0xa0
[ 2499.460748]  set_next_entity+0x3b0/0x5f8
[ 2499.460749]  get_signal+0x13c/0x444
[ 2499.460750]  0x33
[ 2499.460751]  do_signal+0x68/0x1c0
[ 2499.460752] Task dump for CPU 6:
[ 2499.460753]  do_notify_resume+0xcc/0x10c
[ 2499.460754] java            X
[ 2499.460755]  work_pending+0x8/0x10
[ 2499.460755]   running task
[ 2499.460756] Task dump for CPU 21:
[ 2499.460756]     0  4755      1 0x00000229
[ 2499.460757] java            X
[ 2499.460757] Call trace:
[ 2499.460758]   running task
[ 2499.460759]  __switch_to+0x8c/0xa8
[ 2499.460760]     0  2465      0 0x00000228
[ 2499.460761]  set_next_entity+0x3b0/0x5f8
[ 2499.460761] Call trace:
[ 2499.460762]  0x33
[ 2499.460764]  __switch_to+0x8c/0xa8
[ 2499.460764] Task dump for CPU 7:
[ 2499.460765]  0xe
[ 2499.460765] java            X
[ 2499.460766] Task dump for CPU 22:
[ 2499.460766]   running task
[ 2499.460767] systemd-journal R
[ 2499.460768]     0  4529      1 0x00000229
[ 2499.460768]   running task
[ 2499.460769] Call trace:
[ 2499.460770]     0   897      1 0x00000028
[ 2499.460771]  __switch_to+0x8c/0xa8
[ 2499.460771] Call trace:
[ 2499.460772]  set_next_entity+0x3b0/0x5f8
[ 2499.460773]  __switch_to+0x8c/0xa8
[ 2499.460774]  0x33
[ 2499.460777]  elf_core_dump+0x98/0x86c
[ 2499.460777] Task dump for CPU 8:
[ 2499.460779]  do_coredump+0x938/0xc9c
[ 2499.460780] java            X
[ 2499.460781]  get_signal+0x134/0x444
[ 2499.460781]   running task
[ 2499.460783]  do_signal+0x68/0x1c0
[ 2499.460783]     0  4577      1 0x00000229
[ 2499.460785]  do_notify_resume+0xcc/0x10c
[ 2499.460785] Call trace:
[ 2499.460786]  work_pending+0x8/0x10
[ 2499.460787]  __switch_to+0x8c/0xa8
[ 2499.460788] Task dump for CPU 23:
[ 2499.460789]  set_next_entity+0x3b0/0x5f8
[ 2499.460790] java            X
[ 2499.460790]  0x33
[ 2499.460791]   running task
[ 2499.460791] Task dump for CPU 9:
[ 2499.460792]     0  4627      1 0x00000229
[ 2499.460793] java            X
[ 2499.460793] Call trace:
[ 2499.460793]   running task
[ 2499.460795]  __switch_to+0x8c/0xa8
[ 2499.460796]     0  6979      1 0x00000229
[ 2499.460797]  set_next_entity+0x3b0/0x5f8
[ 2499.460797] Call trace:
[ 2499.460798]  0x33
[ 2499.460799]  __switch_to+0x8c/0xa8
[ 2499.460800] Task dump for CPU 24:
[ 2499.460801]  set_next_entity+0x3b0/0x5f8
[ 2499.460801] java            X
[ 2499.460802]  0x33
[ 2499.460802]   running task
[ 2499.460803] Task dump for CPU 10:
[ 2499.460804]     0  4703      1 0x0000022b
[ 2499.460804] stop-cassandra. S
[ 2499.460805] Call trace:
[ 2499.460805]     0 14808  14764 0x00000208
[ 2499.460807]  __switch_to+0x8c/0xa8
[ 2499.460807] Call trace:
[ 2499.460808]  set_next_entity+0x3b0/0x5f8
[ 2499.460809]  __switch_to+0x8c/0xa8
[ 2499.460810]  0x33
[ 2499.460811]  0xffff00004bd2fd90
[ 2499.460811] Task dump for CPU 25:
[ 2499.460812] Task dump for CPU 11:
[ 2499.460812] java            R
[ 2499.460813] java            X
[ 2499.460813]   running task
[ 2499.460814]   running task
[ 2499.460815]     0  8685      1 0x00000209
[ 2499.460816]     0  2496      1 0x00000229
[ 2499.460816] Call trace:
[ 2499.460816] Call trace:
[ 2499.460818]  __switch_to+0x8c/0xa8
[ 2499.460819]  __switch_to+0x8c/0xa8
[ 2499.460820]  do_exit+0x13c/0x9d0
[ 2499.460821]  set_next_entity+0x3b0/0x5f8
[ 2499.460822]  do_group_exit+0x38/0xa0
[ 2499.460823]  0x33
[ 2499.460824]  get_signal+0x13c/0x444
[ 2499.460824] Task dump for CPU 12:
[ 2499.460825]  do_signal+0x68/0x1c0
[ 2499.460826] java            X
[ 2499.460827]  do_notify_resume+0xcc/0x10c
[ 2499.460827]   running task
[ 2499.460829]  work_pending+0x8/0x10
[ 2499.460830]     0  4586      0 0x00000228
[ 2499.460830] Task dump for CPU 26:
[ 2499.460830] Call trace:
[ 2499.460831] swapper/26      R
[ 2499.460832]  __switch_to+0x8c/0xa8
[ 2499.460833]   running task
[ 2499.460834]  0xe
[ 2499.460834]     0     0      1 0x00000000
[ 2499.460835] Task dump for CPU 13:
[ 2499.460835] Call trace:
[ 2499.460836] java            X
[ 2499.460837]  __switch_to+0x8c/0xa8
[ 2499.460837]   running task
[ 2499.460839]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.460840]     0  4572      1 0x00000229
[ 2499.460840]            (null)
[ 2499.460840] Call trace:
[ 2499.460841] Task dump for CPU 27:
[ 2499.460842]  __switch_to+0x8c/0xa8
[ 2499.460843] java            X
[ 2499.460844]  set_next_entity+0x3b0/0x5f8
[ 2499.460844]   running task
[ 2499.460845]  0x33
[ 2499.460846]     0  4954      0 0x00000228
[ 2499.460846] Task dump for CPU 14:
[ 2499.460846] Call trace:
[ 2499.460847] java            X
[ 2499.460848]  __switch_to+0x8c/0xa8
[ 2499.460848]   running task
[ 2499.460849]  0xe
[ 2499.460850]     0 10425      0 0x00000228
[ 2499.460851] Task dump for CPU 28:
[ 2499.460851] Call trace:
[ 2499.460852] swapper/28      R
[ 2499.460853]  dump_backtrace+0x0/0x178
[ 2499.460854]   running task
[ 2499.460855]  show_stack+0x14/0x1c
[ 2499.460856]     0     0      1 0x00000000
[ 2499.460857]  sched_show_task+0x120/0x138
[ 2499.460858] Call trace:
[ 2499.460859]  dump_cpu_task+0x40/0x4c
[ 2499.460860]  __switch_to+0x8c/0xa8
[ 2499.460861]  rcu_dump_cpu_stacks+0xa4/0xe4
[ 2499.460863]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.460864]  rcu_check_callbacks+0x760/0x970
[ 2499.460864]            (null)
[ 2499.460866]  update_process_times+0x2c/0x54
[ 2499.460866] Task dump for CPU 29:
[ 2499.460868]  tick_sched_handle.isra.13+0x34/0x54
[ 2499.460868] java            X
[ 2499.460870]  tick_sched_timer+0x40/0x80
[ 2499.460870]   running task
[ 2499.460871]  __hrtimer_run_queues+0xdc/0x130
[ 2499.460872]     0  4385      1 0x00000229
[ 2499.460873]  hrtimer_interrupt+0x98/0x1cc
[ 2499.460873] Call trace:
[ 2499.460875]  arch_timer_handler_phys+0x2c/0x38
[ 2499.460876]  __switch_to+0x8c/0xa8
[ 2499.460878]  handle_percpu_devid_irq+0x78/0x120
[ 2499.460879]  set_next_entity+0x3b0/0x5f8
[ 2499.460880]  generic_handle_irq+0x24/0x38
[ 2499.460881]  0x33
[ 2499.460882]  __handle_domain_irq+0x60/0xb4
[ 2499.460883] Task dump for CPU 30:
[ 2499.460884]  gic_handle_irq+0x98/0x1b0
[ 2499.460884] java            X
[ 2499.460885]  el1_irq+0xb0/0x140
[ 2499.460886]   running task
[ 2499.460887]  release_task+0x374/0x520
[ 2499.460888]     0  8678      1 0x00000229
[ 2499.460889]  do_exit+0x50c/0x9d0
[ 2499.460889] Call trace:
[ 2499.460890]  do_group_exit+0x38/0xa0
[ 2499.460892]  __switch_to+0x8c/0xa8
[ 2499.460893]  get_signal+0x13c/0x444
[ 2499.460894]  do_exit+0x2a4/0x9d0
[ 2499.460895]  do_signal+0x68/0x1c0
[ 2499.460896]  do_group_exit+0x38/0xa0
[ 2499.460898]  do_notify_resume+0xcc/0x10c
[ 2499.460899]  get_signal+0x13c/0x444
[ 2499.460900]  work_pending+0x8/0x10
[ 2499.460901]  do_signal+0x68/0x1c0
[ 2499.460902] Task dump for CPU 15:
[ 2499.460903]  do_notify_resume+0xcc/0x10c
[ 2499.460903] java            X
[ 2499.460904]  work_pending+0x8/0x10
[ 2499.460905]   running task
[ 2499.460905] Task dump for CPU 31:
[ 2499.460906]     0  8654      0 0x00000228
[ 2499.460907] java            X
[ 2499.460907] Call trace:
[ 2499.460908]   running task
[ 2499.460909]  __switch_to+0x8c/0xa8
[ 2499.460910]     0  4558      0 0x0000022a
[ 2499.460910]            (null)
[ 2499.460911] Call trace:
[ 2499.460912]  do_group_exit+0x38/0xa0
[ 2499.460913]  __switch_to+0x8c/0xa8
[ 2499.460914]  get_signal+0x13c/0x444
[ 2499.460915]  0xe
[ 2499.460916]  do_signal+0x68/0x1c0
[ 2499.460917]  do_notify_resume+0xcc/0x10c
[ 2499.460918]  work_pending+0x8/0x10
[ 2499.460919] Task dump for CPU 16:
[ 2499.460920] Task dump for CPU 0:
[ 2499.460920] java            X
[ 2499.460921] java            X
[ 2499.460921]   running task
[ 2499.460922]   running task
[ 2499.460923]     0  4580      0 0x00000228
[ 2499.460924]     0  6128      1 0x00000229
[ 2499.460924] Call trace:
[ 2499.460925] Call trace:
[ 2499.460926]  __switch_to+0x8c/0xa8
[ 2499.460928]  dump_backtrace+0x0/0x178
[ 2499.460928]  0xe
[ 2499.460930]  show_stack+0x14/0x1c
[ 2499.460930] Task dump for CPU 17:
[ 2499.460931]  sched_show_task+0x120/0x138
[ 2499.460932] java            X
[ 2499.460933]  dump_cpu_task+0x40/0x4c
[ 2499.460933]   running task
[ 2499.460935]  rcu_dump_cpu_stacks+0xa4/0xe4
[ 2499.460936]     0  4538      1 0x00000229
[ 2499.460937]  rcu_check_callbacks+0x760/0x970
[ 2499.460937] Call trace:
[ 2499.460939]  update_process_times+0x2c/0x54
[ 2499.460940]  __switch_to+0x8c/0xa8
[ 2499.460942]  tick_sched_handle.isra.13+0x34/0x54
[ 2499.460943]  set_next_entity+0x3b0/0x5f8
[ 2499.460944]  tick_sched_timer+0x40/0x80
[ 2499.460944]  0x33
[ 2499.460946]  __hrtimer_run_queues+0xdc/0x130
[ 2499.460946] Task dump for CPU 18:
[ 2499.460947]  hrtimer_interrupt+0x98/0x1cc
[ 2499.460947] abrt-hook-ccpp  R
[ 2499.460949]  arch_timer_handler_phys+0x2c/0x38
[ 2499.460949]   running task
[ 2499.460950]  handle_percpu_devid_irq+0x78/0x120
[ 2499.460951]     0 14811      2 0x00000200
[ 2499.460953]  generic_handle_irq+0x24/0x38
[ 2499.460953] Call trace:
[ 2499.460955]  __handle_domain_irq+0x60/0xb4
[ 2499.460956]  ret_from_fork+0x0/0x18
[ 2499.460957]  gic_handle_irq+0x98/0x1b0
[ 2499.460957] Task dump for CPU 19:
[ 2499.460958]  el1_irq+0xb0/0x140
[ 2499.460959] java            X
[ 2499.460960]  do_exit+0x4b4/0x9d0
[ 2499.460960]   running task
[ 2499.460961]  do_group_exit+0x38/0xa0
[ 2499.460962]     0  6708      1 0x00000229
[ 2499.460963]  get_signal+0x13c/0x444
[ 2499.460964] Call trace:
[ 2499.460965]  do_signal+0x68/0x1c0
[ 2499.460966]  __switch_to+0x8c/0xa8
[ 2499.460968]  do_notify_resume+0xcc/0x10c
[ 2499.460969]  do_exit+0x2a4/0x9d0
[ 2499.460970]  work_pending+0x8/0x10
[ 2499.460971]  do_group_exit+0x38/0xa0
[ 2499.460972] Task dump for CPU 1:
[ 2499.460973]  get_signal+0x13c/0x444
[ 2499.460973] java            X
[ 2499.460975]  do_signal+0x68/0x1c0
[ 2499.460975]   running task
[ 2499.460977]  do_notify_resume+0xcc/0x10c
[ 2499.460978]     0  4461      0 0x0000022a
[ 2499.460979]  work_pending+0x8/0x10
[ 2499.460979] Call trace:
[ 2499.460979] Task dump for CPU 20:
[ 2499.460981]  __switch_to+0x8c/0xa8
[ 2499.460981] java            X
[ 2499.460982]  0xe
[ 2499.460982]   running task
[ 2499.460983] Task dump for CPU 2:
[ 2499.460984]     0 10449      1 0x00000221
[ 2499.460984] sh              R
[ 2499.460985] Call trace:
[ 2499.460985]   running task
[ 2499.460986]  __switch_to+0x8c/0xa8
[ 2499.460987]     0 14810   1402 0x00000200
[ 2499.460988]  do_exit+0x2a4/0x9d0
[ 2499.460988] Call trace:
[ 2499.460989]  do_group_exit+0x38/0xa0
[ 2499.460991]  ret_from_fork+0x0/0x18
[ 2499.460991]  get_signal+0x13c/0x444
[ 2499.460992] Task dump for CPU 3:
[ 2499.460993]  do_signal+0x68/0x1c0
[ 2499.460994] java            X
[ 2499.460995]  do_notify_resume+0xcc/0x10c
[ 2499.460995]   running task
[ 2499.460997]  work_pending+0x8/0x10
[ 2499.460997]     0  7041      0 0x0000022a
[ 2499.460998] Task dump for CPU 21:
[ 2499.460998] Call trace:
[ 2499.460999] java            X
[ 2499.461000]  __switch_to+0x8c/0xa8
[ 2499.461000]   running task
[ 2499.461001]  0xe
[ 2499.461002]     0  2465      0 0x00000228
[ 2499.461002] Task dump for CPU 4:
[ 2499.461003] Call trace:
[ 2499.461003] java            X
[ 2499.461004]  __switch_to+0x8c/0xa8
[ 2499.461005]   running task
[ 2499.461006]  0xe
[ 2499.461006]     0  4660      0 0x00000228
[ 2499.461007] Task dump for CPU 22:
[ 2499.461007] Call trace:
[ 2499.461008] systemd-journal R
[ 2499.461009]  __switch_to+0x8c/0xa8
[ 2499.461009]   running task
[ 2499.461010]  0xe
[ 2499.461011]     0   897      1 0x00000028
[ 2499.461011] Task dump for CPU 5:
[ 2499.461012] Call trace:
[ 2499.461012] java            X
[ 2499.461013]  __switch_to+0x8c/0xa8
[ 2499.461014]   running task
[ 2499.461014]  0x10000
[ 2499.461015]     0  4546      1 0x00000229
[ 2499.461016]  0xffff00002c82fec0
[ 2499.461016] Call trace:
[ 2499.461017]  0xffff000000000000
[ 2499.461018]  __switch_to+0x8c/0xa8
[ 2499.461019] Task dump for CPU 23:
[ 2499.461020]  set_next_entity+0x3b0/0x5f8
[ 2499.461020] java            X
[ 2499.461021]  0x33
[ 2499.461021]   running task
[ 2499.461022] Task dump for CPU 6:
[ 2499.461023]     0  4627      1 0x00000229
[ 2499.461023] java            X
[ 2499.461023] Call trace:
[ 2499.461024]   running task
[ 2499.461025]  __switch_to+0x8c/0xa8
[ 2499.461026]     0  4755      1 0x00000229
[ 2499.461027]  set_next_entity+0x3b0/0x5f8
[ 2499.461027] Call trace:
[ 2499.461028]  0x33
[ 2499.461029]  __switch_to+0x8c/0xa8
[ 2499.461030] Task dump for CPU 24:
[ 2499.461031]  set_next_entity+0x3b0/0x5f8
[ 2499.461031] java            X
[ 2499.461032]  0x33
[ 2499.461032]   running task
[ 2499.461033] Task dump for CPU 7:
[ 2499.461033]     0  4703      1 0x0000022b
[ 2499.461034] java            X
[ 2499.461034] Call trace:
[ 2499.461035]   running task
[ 2499.461036]  __switch_to+0x8c/0xa8
[ 2499.461037]     0  4529      1 0x00000229
[ 2499.461038]  set_next_entity+0x3b0/0x5f8
[ 2499.461038] Call trace:
[ 2499.461039]  0x33
[ 2499.461040]  __switch_to+0x8c/0xa8
[ 2499.461040] Task dump for CPU 25:
[ 2499.461041]  set_next_entity+0x3b0/0x5f8
[ 2499.461042] swapper/25      R
[ 2499.461043]  0x33
[ 2499.461043]   running task
[ 2499.461044] Task dump for CPU 8:
[ 2499.461044]     0     0      1 0x00000000
[ 2499.461045] java            X
[ 2499.461045] Call trace:
[ 2499.461046]   running task
[ 2499.461047]  __switch_to+0x8c/0xa8
[ 2499.461048]     0  4577      1 0x00000229
[ 2499.461049]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.461049] Call trace:
[ 2499.461050]            (null)
[ 2499.461051]  __switch_to+0x8c/0xa8
[ 2499.461052] Task dump for CPU 26:
[ 2499.461053]  set_next_entity+0x3b0/0x5f8
[ 2499.461053] swapper/26      R
[ 2499.461054]  0x33
[ 2499.461054]   running task
[ 2499.461055] Task dump for CPU 9:
[ 2499.461056]     0     0      1 0x00000000
[ 2499.461056] java            X
[ 2499.461056] Call trace:
[ 2499.461057]   running task
[ 2499.461058]  __switch_to+0x8c/0xa8
[ 2499.461059]     0  6979      1 0x00000229
[ 2499.461060]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.461060] Call trace:
[ 2499.461061]            (null)
[ 2499.461062]  __switch_to+0x8c/0xa8
[ 2499.461063] Task dump for CPU 27:
[ 2499.461064]  set_next_entity+0x3b0/0x5f8
[ 2499.461064] java            X
[ 2499.461065]  0x33
[ 2499.461065]   running task
[ 2499.461066] Task dump for CPU 10:
[ 2499.461067]     0  4954      0 0x00000228
[ 2499.461067] stop-cassandra. S
[ 2499.461067] Call trace:
[ 2499.461068]     0 14808  14764 0x00000208
[ 2499.461069]  __switch_to+0x8c/0xa8
[ 2499.461070] Call trace:
[ 2499.461070]  0xe
[ 2499.461072]  __switch_to+0x8c/0xa8
[ 2499.461072] Task dump for CPU 28:
[ 2499.461073]  0xffff00004bd2fd90
[ 2499.461073] swapper/28      R
[ 2499.461074] Task dump for CPU 11:
[ 2499.461074]   running task
[ 2499.461075] java            X
[ 2499.461076]     0     0      1 0x00000000
[ 2499.461076]   running task
[ 2499.461077] Call trace:
[ 2499.461078]     0  2496      1 0x00000229
[ 2499.461079]  __switch_to+0x8c/0xa8
[ 2499.461079] Call trace:
[ 2499.461080]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.461082]  __switch_to+0x8c/0xa8
[ 2499.461082]            (null)
[ 2499.461083]  set_next_entity+0x3b0/0x5f8
[ 2499.461084] Task dump for CPU 29:
[ 2499.461084]  0x33
[ 2499.461085] java            X
[ 2499.461085] Task dump for CPU 12:
[ 2499.461086]   running task
[ 2499.461086] java            X
[ 2499.461087]     0  4385      1 0x00000229
[ 2499.461088]   running task
[ 2499.461088] Call trace:
[ 2499.461089]     0  4586      0 0x00000228
[ 2499.461090]  __switch_to+0x8c/0xa8
[ 2499.461090] Call trace:
[ 2499.461092]  set_next_entity+0x3b0/0x5f8
[ 2499.461093]  __switch_to+0x8c/0xa8
[ 2499.461093]  0x33
[ 2499.461094]  0xe
[ 2499.461094] Task dump for CPU 30:
[ 2499.461095] Task dump for CPU 13:
[ 2499.461095] java            X
[ 2499.461096] java            X
[ 2499.461096]   running task
[ 2499.461097]   running task
[ 2499.461098]     0  8678      1 0x00000229
[ 2499.461098]     0  4572      1 0x00000229
[ 2499.461099] Call trace:
[ 2499.461099] Call trace:
[ 2499.461100]  __switch_to+0x8c/0xa8
[ 2499.461102]  __switch_to+0x8c/0xa8
[ 2499.461103]  do_exit+0x2a4/0x9d0
[ 2499.461104]  set_next_entity+0x3b0/0x5f8
[ 2499.461105]  do_group_exit+0x38/0xa0
[ 2499.461105]  0x33
[ 2499.461106]  get_signal+0x13c/0x444
[ 2499.461107] Task dump for CPU 14:
[ 2499.461108]  do_signal+0x68/0x1c0
[ 2499.461109] java            X
[ 2499.461110]  do_notify_resume+0xcc/0x10c
[ 2499.461110]   running task
[ 2499.461111]  work_pending+0x8/0x10
[ 2499.461112]     0 10425      0 0x00000228
[ 2499.461113] Task dump for CPU 31:
[ 2499.461113] Call trace:
[ 2499.461113] java            X
[ 2499.461115]  __switch_to+0x8c/0xa8
[ 2499.461115]   running task
[ 2499.461116]            (null)
[ 2499.461117]     0  4558      0 0x0000022a
[ 2499.461118]  do_group_exit+0x38/0xa0
[ 2499.461118] Call trace:
[ 2499.461119]  get_signal+0x13c/0x444
[ 2499.461120]  __switch_to+0x8c/0xa8
[ 2499.461122]  do_signal+0x68/0x1c0
[ 2499.461122]  0xe
[ 2499.461123]  do_notify_resume+0xcc/0x10c
[ 2499.461124]  work_pending+0x8/0x10
[ 2499.461125] Task dump for CPU 15:
[ 2499.461126] java            X  running task        0  8654      0 0x00000228
[ 2499.461128] Call trace:
[ 2499.461129]  __switch_to+0x8c/0xa8
[ 2499.461130]            (null)
[ 2499.461131]  do_group_exit+0x38/0xa0
[ 2499.461132]  get_signal+0x13c/0x444
[ 2499.461133]  do_signal+0x68/0x1c0
[ 2499.461134]  do_notify_resume+0xcc/0x10c
[ 2499.461135]  work_pending+0x8/0x10
[ 2499.461136] Task dump for CPU 16:
[ 2499.461137] Task dump for CPU 0:
[ 2499.461137] java            X
[ 2499.461138] java            X
[ 2499.461139]   running task
[ 2499.461139]   running task
[ 2499.461140]     0  4580      0 0x00000228
[ 2499.461141]     0  6128      1 0x00000229
[ 2499.461142] Call trace:
[ 2499.461142] Call trace:
[ 2499.461143]  __switch_to+0x8c/0xa8
[ 2499.461145]  __switch_to+0x8c/0xa8
[ 2499.461145]  0xe
[ 2499.461147]  set_next_entity+0x3b0/0x5f8
[ 2499.461147] Task dump for CPU 17:
[ 2499.461148]  0x33
[ 2499.461148] java            X
[ 2499.461149] Task dump for CPU 1:
[ 2499.461149]   running task
[ 2499.461150] java            X
[ 2499.461151]     0  4538      1 0x00000229
[ 2499.461151]   running task
[ 2499.461152] Call trace:
[ 2499.461153]     0  4461      0 0x0000022a
[ 2499.461154]  __switch_to+0x8c/0xa8
[ 2499.461155] Call trace:
[ 2499.461156]  set_next_entity+0x3b0/0x5f8
[ 2499.461157]  __switch_to+0x8c/0xa8
[ 2499.461158]  0x33
[ 2499.461158]  0xe
[ 2499.461159] Task dump for CPU 18:
[ 2499.461159] Task dump for CPU 2:
[ 2499.461160] abrt-hook-ccpp  R
[ 2499.461160] sh              R
[ 2499.461161]   running task
[ 2499.461161]   running task
[ 2499.461162]     0 14811      2 0x00000200
[ 2499.461163]     0 14810   1402 0x00000200
[ 2499.461164] Call trace:
[ 2499.461164] Call trace:
[ 2499.461165]  ret_from_fork+0x0/0x18
[ 2499.461166]  ret_from_fork+0x0/0x18
[ 2499.461167] Task dump for CPU 19:
[ 2499.461167] Task dump for CPU 3:
[ 2499.461168] java            X
[ 2499.461168] java            X
[ 2499.461169]   running task
[ 2499.461169]   running task
[ 2499.461170]     0  6708      1 0x00000229
[ 2499.461171]     0  7041      0 0x0000022a
[ 2499.461171] Call trace:
[ 2499.461172] Call trace:
[ 2499.461173]  __switch_to+0x8c/0xa8
[ 2499.461174]  __switch_to+0x8c/0xa8
[ 2499.461175]  do_exit+0x2a4/0x9d0
[ 2499.461176]  0xe
[ 2499.461177]  do_group_exit+0x38/0xa0
[ 2499.461177] Task dump for CPU 4:
[ 2499.461178]  get_signal+0x13c/0x444
[ 2499.461179] java            X
[ 2499.461180]  do_signal+0x68/0x1c0
[ 2499.461181]   running task
[ 2499.461182]  do_notify_resume+0xcc/0x10c
[ 2499.461183]     0  4660      0 0x00000228
[ 2499.461184]  work_pending+0x8/0x10
[ 2499.461184] Call trace:
[ 2499.461185] Task dump for CPU 20:
[ 2499.461186]  __switch_to+0x8c/0xa8
[ 2499.461186] java            X
[ 2499.461187]  0xe
[ 2499.461187]   running task
[ 2499.461188] Task dump for CPU 5:
[ 2499.461189]     0 10449      1 0x00000221
[ 2499.461189] java            X
[ 2499.461190] Call trace:
[ 2499.461190]   running task
[ 2499.461192]  __switch_to+0x8c/0xa8
[ 2499.461193]     0  4546      1 0x00000229
[ 2499.461194]  do_exit+0x2a4/0x9d0
[ 2499.461194] Call trace:
[ 2499.461195]  do_group_exit+0x38/0xa0
[ 2499.461196]  __switch_to+0x8c/0xa8
[ 2499.461197]  get_signal+0x13c/0x444
[ 2499.461198]  set_next_entity+0x3b0/0x5f8
[ 2499.461200]  do_signal+0x68/0x1c0
[ 2499.461200]  0x33
[ 2499.461202]  do_notify_resume+0xcc/0x10c
[ 2499.461202] Task dump for CPU 6:
[ 2499.461203]  work_pending+0x8/0x10
[ 2499.461203] java            X
[ 2499.461204] Task dump for CPU 21:
[ 2499.461204]   running task
[ 2499.461205] java            X
[ 2499.461206]     0  4755      1 0x00000229
[ 2499.461206]   running task
[ 2499.461207] Call trace:
[ 2499.461208]     0  2465      0 0x00000228
[ 2499.461209]  dump_backtrace+0x0/0x178
[ 2499.461209] Call trace:
[ 2499.461211]  show_stack+0x14/0x1c
[ 2499.461212]  __switch_to+0x8c/0xa8
[ 2499.461213]  sched_show_task+0x120/0x138
[ 2499.461214]  0xe
[ 2499.461215]  dump_cpu_task+0x40/0x4c
[ 2499.461216] Task dump for CPU 22:
[ 2499.461217]  rcu_dump_cpu_stacks+0xa4/0xe4
[ 2499.461217] java            R
[ 2499.461219]  rcu_check_callbacks+0x760/0x970
[ 2499.461219]   running task
[ 2499.461220]  update_process_times+0x2c/0x54
[ 2499.461221]     0  6566      1 0x00000229
[ 2499.461223]  tick_sched_handle.isra.13+0x34/0x54
[ 2499.461223] Call trace:
[ 2499.461224]  tick_sched_timer+0x40/0x80
[ 2499.461226]  __switch_to+0x8c/0xa8
[ 2499.461227]  __hrtimer_run_queues+0xdc/0x130
[ 2499.461228]  0x6929bbef0d794900
[ 2499.461228]  hrtimer_interrupt+0x98/0x1cc
[ 2499.461230]  arch_timer_handler_phys+0x2c/0x38
[ 2499.461232]  handle_percpu_devid_irq+0x78/0x120
[ 2499.461232] Task dump for CPU 23:
[ 2499.461234]  generic_handle_irq+0x24/0x38
[ 2499.461234] java            X
[ 2499.461236]  __handle_domain_irq+0x60/0xb4
[ 2499.461236]   running task
[ 2499.461237]  gic_handle_irq+0x98/0x1b0
[ 2499.461238]     0  4627      1 0x00000229
[ 2499.461239]  el1_irq+0xb0/0x140
[ 2499.461240] Call trace:
[ 2499.461241]  do_exit+0x4b4/0x9d0
[ 2499.461242]  __switch_to+0x8c/0xa8
[ 2499.461243]  do_group_exit+0x38/0xa0
[ 2499.461244]  set_next_entity+0x3b0/0x5f8
[ 2499.461246]  get_signal+0x13c/0x444
[ 2499.461246]  0x33
[ 2499.461248]  do_signal+0x68/0x1c0
[ 2499.461248] Task dump for CPU 24:
[ 2499.461250]  do_notify_resume+0xcc/0x10c
[ 2499.461250] java            X
[ 2499.461251]  work_pending+0x8/0x10
[ 2499.461251]   running task
[ 2499.461252] Task dump for CPU 7:
[ 2499.461253]     0  4703      1 0x0000022b
[ 2499.461253] java            X
[ 2499.461254] Call trace:
[ 2499.461254]   running task
[ 2499.461255]  __switch_to+0x8c/0xa8
[ 2499.461256]     0  4529      1 0x00000229
[ 2499.461258]  set_next_entity+0x3b0/0x5f8
[ 2499.461258] Call trace:
[ 2499.461258]  0x33
[ 2499.461260]  __switch_to+0x8c/0xa8
[ 2499.461260] Task dump for CPU 25:
[ 2499.461261]  set_next_entity+0x3b0/0x5f8
[ 2499.461262] swapper/25      R
[ 2499.461263]  0x33
[ 2499.461263]   running task
[ 2499.461264] Task dump for CPU 8:
[ 2499.461264]     0     0      1 0x00000000
[ 2499.461265] java            X
[ 2499.461265] Call trace:
[ 2499.461266]   running task
[ 2499.461267]  __switch_to+0x8c/0xa8
[ 2499.461268]     0  4577      1 0x00000229
[ 2499.461269]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.461270] Call trace:
[ 2499.461270]            (null)
[ 2499.461272]  __switch_to+0x8c/0xa8
[ 2499.461272] Task dump for CPU 26:
[ 2499.461273]  set_next_entity+0x3b0/0x5f8
[ 2499.461274] swapper/26      R
[ 2499.461275]  0x33
[ 2499.461275]   running task
[ 2499.461276] Task dump for CPU 9:
[ 2499.461276]     0     0      1 0x00000000
[ 2499.461277] java            X
[ 2499.461277] Call trace:
[ 2499.461278]   running task
[ 2499.461279]  __switch_to+0x8c/0xa8
[ 2499.461280]     0  6979      1 0x00000229
[ 2499.461281]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.461281] Call trace:
[ 2499.461282]            (null)
[ 2499.461283]  __switch_to+0x8c/0xa8
[ 2499.461284] Task dump for CPU 27:
[ 2499.461285]  set_next_entity+0x3b0/0x5f8
[ 2499.461285] java            X
[ 2499.461286]  0x33
[ 2499.461286]   running task
[ 2499.461287] Task dump for CPU 10:
[ 2499.461288]     0  4954      0 0x00000228
[ 2499.461288] stop-cassandra. S
[ 2499.461289] Call trace:
[ 2499.461290]     0 14808  14764 0x00000208
[ 2499.461291]  __switch_to+0x8c/0xa8
[ 2499.461291] Call trace:
[ 2499.461292]  0xe
[ 2499.461293]  __switch_to+0x8c/0xa8
[ 2499.461294] Task dump for CPU 28:
[ 2499.461295]  0xffff00004bd2fd90
[ 2499.461295] swapper/28      R
[ 2499.461296] Task dump for CPU 11:
[ 2499.461296]   running task
[ 2499.461297] java            X
[ 2499.461298]     0     0      1 0x00000000
[ 2499.461298]   running task
[ 2499.461298] Call trace:
[ 2499.461299]     0  2496      1 0x00000229
[ 2499.461301]  __switch_to+0x8c/0xa8
[ 2499.461301] Call trace:
[ 2499.461302]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.461304]  __switch_to+0x8c/0xa8
[ 2499.461304]            (null)
[ 2499.461305]  set_next_entity+0x3b0/0x5f8
[ 2499.461306] Task dump for CPU 29:
[ 2499.461306]  0x33
[ 2499.461307] java            X
[ 2499.461307] Task dump for CPU 12:
[ 2499.461308]   running task
[ 2499.461308] java            X
[ 2499.461309]     0  4385      1 0x00000229
[ 2499.461310]   running task
[ 2499.461310] Call trace:
[ 2499.461311]     0  4586      0 0x00000228
[ 2499.461312]  __switch_to+0x8c/0xa8
[ 2499.461313] Call trace:
[ 2499.461314]  set_next_entity+0x3b0/0x5f8
[ 2499.461315]  __switch_to+0x8c/0xa8
[ 2499.461316]  0x33
[ 2499.461317]  0xe
[ 2499.461317] Task dump for CPU 30:
[ 2499.461318] Task dump for CPU 13:
[ 2499.461318] java            X
[ 2499.461319] java            X
[ 2499.461319]   running task
[ 2499.461320]   running task
[ 2499.461321]     0  8678      1 0x00000229
[ 2499.461321]     0  4572      1 0x00000229
[ 2499.461322] Call trace:
[ 2499.461322] Call trace:
[ 2499.461323]  __switch_to+0x8c/0xa8
[ 2499.461325]  __switch_to+0x8c/0xa8
[ 2499.461326]  do_exit+0x2a4/0x9d0
[ 2499.461327]  set_next_entity+0x3b0/0x5f8
[ 2499.461328]  do_group_exit+0x38/0xa0
[ 2499.461329]  0x33
[ 2499.461330]  get_signal+0x13c/0x444
[ 2499.461330] Task dump for CPU 14:
[ 2499.461331]  do_signal+0x68/0x1c0
[ 2499.461332] java            X
[ 2499.461333]  do_notify_resume+0xcc/0x10c
[ 2499.461334]   running task
[ 2499.461335]  work_pending+0x8/0x10
[ 2499.461336]     0 10425      0 0x0000022a
[ 2499.461336] Task dump for CPU 31:
[ 2499.461336] Call trace:
[ 2499.461337] java            X
[ 2499.461338]  __switch_to+0x8c/0xa8
[ 2499.461339]   running task
[ 2499.461339]            (null)
[ 2499.461340]     0  4558      0 0x0000022a
[ 2499.461341]  do_group_exit+0x38/0xa0
[ 2499.461342] Call trace:
[ 2499.461343]  get_signal+0x13c/0x444
[ 2499.461344]  __switch_to+0x8c/0xa8
[ 2499.461345]  do_signal+0x68/0x1c0
[ 2499.461346]  0xe
[ 2499.461347]  do_notify_resume+0xcc/0x10c
[ 2499.461348]  work_pending+0x8/0x10
[ 2499.461349] Task dump for CPU 15:
[ 2499.461350] java            X  running task        0  8654      0 0x00000228
[ 2499.461351] Call trace:
[ 2499.461353]  __switch_to+0x8c/0xa8
[ 2499.461353]            (null)
[ 2499.461354]  do_group_exit+0x38/0xa0
[ 2499.461355]  get_signal+0x13c/0x444
[ 2499.461357]  do_signal+0x68/0x1c0
[ 2499.461358]  do_notify_resume+0xcc/0x10c
[ 2499.461359]  work_pending+0x8/0x10
[ 2499.461360] Task dump for CPU 16:
[ 2499.461361] Task dump for CPU 0:
[ 2499.461361] java            X
[ 2499.461362] java            X
[ 2499.461362]   running task
[ 2499.461363]   running task
[ 2499.461364]     0  4580      0 0x00000228
[ 2499.461365]     0  6128      1 0x0000022b
[ 2499.461365] Call trace:
[ 2499.461366] Call trace:
[ 2499.461367]  __switch_to+0x8c/0xa8
[ 2499.461369]  __switch_to+0x8c/0xa8
[ 2499.461369]  0xe
[ 2499.461371]  set_next_entity+0x3b0/0x5f8
[ 2499.461371] Task dump for CPU 17:
[ 2499.461372]  0x33
[ 2499.461372] java            X
[ 2499.461373] Task dump for CPU 1:
[ 2499.461373]   running task
[ 2499.461374] java            X
[ 2499.461375]     0  4538      1 0x00000229
[ 2499.461375]   running task
[ 2499.461376] Call trace:
[ 2499.461377]     0  4461      0 0x0000022a
[ 2499.461378]  __switch_to+0x8c/0xa8
[ 2499.461378] Call trace:
[ 2499.461380]  set_next_entity+0x3b0/0x5f8
[ 2499.461381]  __switch_to+0x8c/0xa8
[ 2499.461382]  0x33
[ 2499.461382]  0xe
[ 2499.461383] Task dump for CPU 18:
[ 2499.461383] Task dump for CPU 2:
[ 2499.461384] abrt-hook-ccpp  R
[ 2499.461384] sh              R
[ 2499.461385]   running task
[ 2499.461385]   running task
[ 2499.461386]     0 14811      2 0x00000200
[ 2499.461387]     0 14810   1402 0x00000200
[ 2499.461387] Call trace:
[ 2499.461388] Call trace:
[ 2499.461389]  ret_from_fork+0x0/0x18
[ 2499.461390]  ret_from_fork+0x0/0x18
[ 2499.461391] Task dump for CPU 19:
[ 2499.461391] Task dump for CPU 3:
[ 2499.461391] java            X
[ 2499.461392] java            X
[ 2499.461393]   running task
[ 2499.461393]   running task
[ 2499.461394]     0  6708      1 0x00000229
[ 2499.461395]     0  7041      0 0x0000022a
[ 2499.461395] Call trace:
[ 2499.461395] Call trace:
[ 2499.461397]  __switch_to+0x8c/0xa8
[ 2499.461398]  __switch_to+0x8c/0xa8
[ 2499.461399]  do_exit+0x2a4/0x9d0
[ 2499.461399]  0xe
[ 2499.461400]  do_group_exit+0x38/0xa0
[ 2499.461401] Task dump for CPU 4:
[ 2499.461402]  get_signal+0x13c/0x444
[ 2499.461402] java            X
[ 2499.461404]  do_signal+0x68/0x1c0
[ 2499.461404]   running task
[ 2499.461405]  do_notify_resume+0xcc/0x10c
[ 2499.461406]     0  4660      0 0x00000228
[ 2499.461407]  work_pending+0x8/0x10
[ 2499.461407] Call trace:
[ 2499.461408] Task dump for CPU 20:
[ 2499.461409]  __switch_to+0x8c/0xa8
[ 2499.461410] java            X
[ 2499.461410]  0xe
[ 2499.461411]   running task
[ 2499.461412] Task dump for CPU 5:
[ 2499.461412]     0 10449      1 0x00000221
[ 2499.461413] java            X
[ 2499.461413] Call trace:
[ 2499.461414]   running task
[ 2499.461415]  __switch_to+0x8c/0xa8
[ 2499.461416]     0  4546      1 0x00000229
[ 2499.461417]  do_exit+0x2a4/0x9d0
[ 2499.461417] Call trace:
[ 2499.461418]  do_group_exit+0x38/0xa0
[ 2499.461420]  __switch_to+0x8c/0xa8
[ 2499.461421]  get_signal+0x13c/0x444
[ 2499.461422]  set_next_entity+0x3b0/0x5f8
[ 2499.461423]  do_signal+0x68/0x1c0
[ 2499.461424]  0x33
[ 2499.461425]  do_notify_resume+0xcc/0x10c
[ 2499.461425] Task dump for CPU 6:
[ 2499.461426]  work_pending+0x8/0x10
[ 2499.461427] java            X
[ 2499.461427] Task dump for CPU 21:
[ 2499.461428]   running task
[ 2499.461428] java            X
[ 2499.461429]     0  4755      1 0x00000229
[ 2499.461429]   running task
[ 2499.461430] Call trace:
[ 2499.461431]     0  2465      0 0x00000228
[ 2499.461432]  __switch_to+0x8c/0xa8
[ 2499.461432] Call trace:
[ 2499.461434]  set_next_entity+0x3b0/0x5f8
[ 2499.461435]  __switch_to+0x8c/0xa8
[ 2499.461435]  0x33
[ 2499.461436]  0xe
[ 2499.461436] Task dump for CPU 7:
[ 2499.461437] Task dump for CPU 22:
[ 2499.461437] java            X
[ 2499.461438] swapper/22      R
[ 2499.461438]   running task
[ 2499.461439]   running task
[ 2499.461440]     0  4529      1 0x00000229
[ 2499.461441]     0     0      1 0x00000000
[ 2499.461441] Call trace:
[ 2499.461442] Call trace:
[ 2499.461443]  __switch_to+0x8c/0xa8
[ 2499.461444]  __switch_to+0x8c/0xa8
[ 2499.461445]  set_next_entity+0x3b0/0x5f8
[ 2499.461447]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.461447]  0x33
[ 2499.461448]            (null)
[ 2499.461448] Task dump for CPU 8:
[ 2499.461448] Task dump for CPU 23:
[ 2499.461449] java            X
[ 2499.461449] java            X
[ 2499.461450]   running task
[ 2499.461450]   running task
[ 2499.461451]     0  4577      1 0x00000229
[ 2499.461452]     0  4627      1 0x00000229
[ 2499.461452] Call trace:
[ 2499.461453] Call trace:
[ 2499.461454]  __switch_to+0x8c/0xa8
[ 2499.461455]  __switch_to+0x8c/0xa8
[ 2499.461456]  set_next_entity+0x3b0/0x5f8
[ 2499.461457]  set_next_entity+0x3b0/0x5f8
[ 2499.461458]  0x33
[ 2499.461458]  0x33
[ 2499.461459] Task dump for CPU 9:
[ 2499.461459] Task dump for CPU 24:
[ 2499.461460] java            X
[ 2499.461460] java            X
[ 2499.461461]   running task
[ 2499.461461]   running task
[ 2499.461462]     0  6979      1 0x00000229
[ 2499.461463]     0  4703      1 0x0000022b
[ 2499.461463] Call trace:
[ 2499.461464] Call trace:
[ 2499.461465]  __switch_to+0x8c/0xa8
[ 2499.461466]  __switch_to+0x8c/0xa8
[ 2499.461467]  set_next_entity+0x3b0/0x5f8
[ 2499.461468]  set_next_entity+0x3b0/0x5f8
[ 2499.461469]  0x33
[ 2499.461469]  0x33
[ 2499.461470] Task dump for CPU 10:
[ 2499.461470] Task dump for CPU 25:
[ 2499.461471] stop-cassandra. S
[ 2499.461471] swapper/25      R
[ 2499.461472]     0 14808  14764 0x00000208
[ 2499.461473]   running task
[ 2499.461473] Call trace:
[ 2499.461474]     0     0      1 0x00000000
[ 2499.461475]  __switch_to+0x8c/0xa8
[ 2499.461475] Call trace:
[ 2499.461476]  0xffff00004bd2fd90
[ 2499.461478]  __switch_to+0x8c/0xa8
[ 2499.461478] Task dump for CPU 11:
[ 2499.461479]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.461480] java            X
[ 2499.461480]            (null)
[ 2499.461480]   running task
[ 2499.461481] Task dump for CPU 26:
[ 2499.461482]     0  2496      1 0x00000229
[ 2499.461482] swapper/26      R
[ 2499.461483] Call trace:
[ 2499.461483]   running task
[ 2499.461485]  __switch_to+0x8c/0xa8
[ 2499.461485]     0     0      1 0x00000000
[ 2499.461487]  set_next_entity+0x3b0/0x5f8
[ 2499.461487] Call trace:
[ 2499.461488]  0x33
[ 2499.461489]  __switch_to+0x8c/0xa8
[ 2499.461489] Task dump for CPU 12:
[ 2499.461490]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.461491] java            X
[ 2499.461491]            (null)
[ 2499.461492]   running task
[ 2499.461492] Task dump for CPU 27:
[ 2499.461493]     0  4586      0 0x00000228
[ 2499.461494] java            X
[ 2499.461494] Call trace:
[ 2499.461494]   running task
[ 2499.461496]  __switch_to+0x8c/0xa8
[ 2499.461497]     0  4954      0 0x00000228
[ 2499.461497]  0xe
[ 2499.461497] Call trace:
[ 2499.461498] Task dump for CPU 13:
[ 2499.461499]  __switch_to+0x8c/0xa8
[ 2499.461500] java            X
[ 2499.461500]  0xe
[ 2499.461501]   running task
[ 2499.461501] Task dump for CPU 28:
[ 2499.461502]     0  4572      1 0x00000229
[ 2499.461502] swapper/28      R
[ 2499.461503] Call trace:
[ 2499.461503]   running task
[ 2499.461504]  __switch_to+0x8c/0xa8
[ 2499.461505]     0     0      1 0x00000000
[ 2499.461506]  set_next_entity+0x3b0/0x5f8
[ 2499.461506] Call trace:
[ 2499.461507]  0x33
[ 2499.461508]  __switch_to+0x8c/0xa8
[ 2499.461509] Task dump for CPU 14:
[ 2499.461510]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.461510] java            X
[ 2499.461511]            (null)
[ 2499.461511]   running task
[ 2499.461512] Task dump for CPU 29:
[ 2499.461513]     0 10425      0 0x0000022a
[ 2499.461513] java            X
[ 2499.461513] Call trace:
[ 2499.461514]   running task
[ 2499.461515]  __switch_to+0x8c/0xa8
[ 2499.461516]     0  4385      1 0x00000229
[ 2499.461517]            (null)
[ 2499.461517] Call trace:
[ 2499.461518]  do_group_exit+0x38/0xa0
[ 2499.461520]  __switch_to+0x8c/0xa8
[ 2499.461521]  get_signal+0x13c/0x444
[ 2499.461522]  set_next_entity+0x3b0/0x5f8
[ 2499.461523]  do_signal+0x68/0x1c0
[ 2499.461524]  0x33
[ 2499.461525]  do_notify_resume+0xcc/0x10c
[ 2499.461526] Task dump for CPU 30:
[ 2499.461527]  work_pending+0x8/0x10
[ 2499.461527] java            X
[ 2499.461528] Task dump for CPU 15:
[ 2499.461528]   running task
[ 2499.461529] java            X
[ 2499.461530]     0  8678      1 0x00000229
[ 2499.461530]   running task
[ 2499.461530] Call trace:
[ 2499.461531]     0  8654      0 0x00000228
[ 2499.461532]  __switch_to+0x8c/0xa8
[ 2499.461533] Call trace:
[ 2499.461534]  do_exit+0x2a4/0x9d0
[ 2499.461535]  __switch_to+0x8c/0xa8
[ 2499.461536]  do_group_exit+0x38/0xa0
[ 2499.461537]            (null)
[ 2499.461537]  get_signal+0x13c/0x444
[ 2499.461538]  do_group_exit+0x38/0xa0
[ 2499.461540]  do_signal+0x68/0x1c0
[ 2499.461541]  get_signal+0x13c/0x444
[ 2499.461542]  do_notify_resume+0xcc/0x10c
[ 2499.461544]  do_signal+0x68/0x1c0
[ 2499.461545]  work_pending+0x8/0x10
[ 2499.461546]  do_notify_resume+0xcc/0x10c
[ 2499.461546] Task dump for CPU 31:
[ 2499.461547]  work_pending+0x8/0x10
[ 2499.461548] java            X
[ 2499.461549] Task dump for CPU 0:
[ 2499.461549]   running task
[ 2499.461550] java            X
[ 2499.461551]     0  4558      0 0x0000022a
[ 2499.461551]   running task
[ 2499.461552] Call trace:
[ 2499.461553]     0  6128      1 0x0000022b
[ 2499.461554]  __switch_to+0x8c/0xa8
[ 2499.461555] Call trace:
[ 2499.461555]  0xe
[ 2499.461557]  __switch_to+0x8c/0xa8
[ 2499.461557] Task dump for CPU 16:
[ 2499.461558]  set_next_entity+0x3b0/0x5f8
[ 2499.461559] java            X
[ 2499.461560]  0x33
[ 2499.461560]   running task
[ 2499.461561] Task dump for CPU 1:
[ 2499.461562]     0  4580      0 0x00000228
[ 2499.461562] java            X
[ 2499.461563] Call trace:
[ 2499.461563]   running task
[ 2499.461564]  __switch_to+0x8c/0xa8
[ 2499.461565]     0  4461      0 0x0000022a
[ 2499.461566]  0xe
[ 2499.461566] Call trace:
[ 2499.461566] Task dump for CPU 17:
[ 2499.461568]  __switch_to+0x8c/0xa8
[ 2499.461568] java            X
[ 2499.461569]  0xe
[ 2499.461569]   running task
[ 2499.461570] Task dump for CPU 2:
[ 2499.461571]     0  4538      1 0x00000229
[ 2499.461571] sh              R
[ 2499.461572] Call trace:
[ 2499.461572]   running task
[ 2499.461573]  __switch_to+0x8c/0xa8
[ 2499.461575]     0 14810   1402 0x00000200
[ 2499.461576]  set_next_entity+0x3b0/0x5f8
[ 2499.461576] Call trace:
[ 2499.461577]  0x33
[ 2499.461578]  ret_from_fork+0x0/0x18
[ 2499.461578] Task dump for CPU 18:
[ 2499.461579] Task dump for CPU 3:
[ 2499.461579] abrt-hook-ccpp  R
[ 2499.461580] java            X
[ 2499.461580]   running task
[ 2499.461581]   running task
[ 2499.461582]     0 14811      2 0x00000200
[ 2499.461583]     0  7041      0 0x0000022a
[ 2499.461583] Call trace:
[ 2499.461584] Call trace:
[ 2499.461585]  ret_from_fork+0x0/0x18
[ 2499.461586]  __switch_to+0x8c/0xa8
[ 2499.461586] Task dump for CPU 19:
[ 2499.461587]  0xe
[ 2499.461587] java            X
[ 2499.461588] Task dump for CPU 4:
[ 2499.461588]   running task
[ 2499.461589] java            X
[ 2499.461590]     0  6708      1 0x00000229
[ 2499.461590]   running task
[ 2499.461591] Call trace:
[ 2499.461592]     0  4660      0 0x00000228
[ 2499.461593]  __switch_to+0x8c/0xa8
[ 2499.461593] Call trace:
[ 2499.461594]  do_exit+0x2a4/0x9d0
[ 2499.461595]  __switch_to+0x8c/0xa8
[ 2499.461596]  do_group_exit+0x38/0xa0
[ 2499.461597]  0xe
[ 2499.461598]  get_signal+0x13c/0x444
[ 2499.461598] Task dump for CPU 5:
[ 2499.461600]  do_signal+0x68/0x1c0
[ 2499.461600] java            X
[ 2499.461602]  do_notify_resume+0xcc/0x10c
[ 2499.461602]   running task
[ 2499.461603]  work_pending+0x8/0x10
[ 2499.461604]     0  4546      1 0x00000229
[ 2499.461604] Task dump for CPU 20:
[ 2499.461605] Call trace:
[ 2499.461605] java            X
[ 2499.461606]  __switch_to+0x8c/0xa8
[ 2499.461607]   running task
[ 2499.461608]  set_next_entity+0x3b0/0x5f8
[ 2499.461609]     0 10449      1 0x00000221
[ 2499.461609]  0x33
[ 2499.461610] Call trace:
[ 2499.461610] Task dump for CPU 6:
[ 2499.461611]  __switch_to+0x8c/0xa8
[ 2499.461612] java            R
[ 2499.461613]  do_exit+0x2a4/0x9d0
[ 2499.461613]   running task
[ 2499.461614]  do_group_exit+0x38/0xa0
[ 2499.461615]     0  4759      1 0x00000229
[ 2499.461617]  get_signal+0x13c/0x444
[ 2499.461617] Call trace:
[ 2499.461618]  do_signal+0x68/0x1c0
[ 2499.461619]  __switch_to+0x8c/0xa8
[ 2499.461621]  do_notify_resume+0xcc/0x10c
[ 2499.461624]  bp_hardening_data+0x0/0x10
[ 2499.461625]  work_pending+0x8/0x10
[ 2499.461625] Task dump for CPU 21:
[ 2499.461626] java            X  running task        0  2465      0 0x00000228
[ 2499.461628] Task dump for CPU 7:
[ 2499.461628] Call trace:
[ 2499.461629] java            X
[ 2499.461630]  __switch_to+0x8c/0xa8
[ 2499.461631]   running task
[ 2499.461632]  0xe
[ 2499.461633]     0  4529      1 0x00000229
[ 2499.461633] Task dump for CPU 22:
[ 2499.461633] Call trace:
[ 2499.461634] swapper/22      R
[ 2499.461635]  __switch_to+0x8c/0xa8
[ 2499.461636]   running task
[ 2499.461637]  set_next_entity+0x3b0/0x5f8
[ 2499.461638]     0     0      1 0x00000000
[ 2499.461638]  0x33
[ 2499.461638] Call trace:
[ 2499.461639] Task dump for CPU 8:
[ 2499.461640]  __switch_to+0x8c/0xa8
[ 2499.461641] java            X
[ 2499.461643]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.461643]   running task
[ 2499.461644]            (null)
[ 2499.461644]     0  4577      1 0x00000229
[ 2499.461645] Task dump for CPU 23:
[ 2499.461645] Call trace:
[ 2499.461646] java            X
[ 2499.461647]  __switch_to+0x8c/0xa8
[ 2499.461648]   running task
[ 2499.461649]  set_next_entity+0x3b0/0x5f8
[ 2499.461650]     0  4627      1 0x00000229
[ 2499.461650]  0x33
[ 2499.461651] Call trace:
[ 2499.461651] Task dump for CPU 9:
[ 2499.461652]  __switch_to+0x8c/0xa8
[ 2499.461653] java            X
[ 2499.461654]  set_next_entity+0x3b0/0x5f8
[ 2499.461654]   running task
[ 2499.461655]  0x33
[ 2499.461656]     0  6979      1 0x00000229
[ 2499.461656] Task dump for CPU 24:
[ 2499.461656] Call trace:
[ 2499.461657] java            X
[ 2499.461658]  __switch_to+0x8c/0xa8
[ 2499.461659]   running task
[ 2499.461660]  set_next_entity+0x3b0/0x5f8
[ 2499.461661]     0  4703      1 0x0000022b
[ 2499.461661]  0x33
[ 2499.461662] Call trace:
[ 2499.461662] Task dump for CPU 10:
[ 2499.461663]  __switch_to+0x8c/0xa8
[ 2499.461664] stop-cassandra. S
[ 2499.461665]  set_next_entity+0x3b0/0x5f8
[ 2499.461666]     0 14808  14764 0x00000208
[ 2499.461666]  0x33
[ 2499.461667] Call trace:
[ 2499.461667] Task dump for CPU 25:
[ 2499.461668]  __switch_to+0x8c/0xa8
[ 2499.461669] swapper/25      R
[ 2499.461670]  0xffff00004bd2fd90
[ 2499.461670]   running task
[ 2499.461671] Task dump for CPU 11:
[ 2499.461672]     0     0      1 0x00000000
[ 2499.461672] java            X
[ 2499.461673] Call trace:
[ 2499.461673]   running task
[ 2499.461674]  __switch_to+0x8c/0xa8
[ 2499.461675]     0  2496      1 0x00000229
[ 2499.461676]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.461676] Call trace:
[ 2499.461677]            (null)
[ 2499.461678]  __switch_to+0x8c/0xa8
[ 2499.461679] Task dump for CPU 26:
[ 2499.461680]  set_next_entity+0x3b0/0x5f8
[ 2499.461680] swapper/26      R
[ 2499.461681]  0x33
[ 2499.461681]   running task
[ 2499.461682] Task dump for CPU 12:
[ 2499.461683]     0     0      1 0x00000000
[ 2499.461683] java            X
[ 2499.461684] Call trace:
[ 2499.461684]   running task
[ 2499.461685]  __switch_to+0x8c/0xa8
[ 2499.461686]     0  4586      0 0x0000022a
[ 2499.461687]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.461687] Call trace:
[ 2499.461688]            (null)
[ 2499.461689]  dump_backtrace+0x0/0x178
[ 2499.461690] Task dump for CPU 27:
[ 2499.461691]  show_stack+0x14/0x1c
[ 2499.461692] java            X
[ 2499.461694]  sched_show_task+0x120/0x138
[ 2499.461694]   running task
[ 2499.461695]  dump_cpu_task+0x40/0x4c
[ 2499.461696]     0  4954      0 0x00000228
[ 2499.461697]  rcu_dump_cpu_stacks+0xa4/0xe4
[ 2499.461698] Call trace:
[ 2499.461699]  rcu_check_callbacks+0x760/0x970
[ 2499.461700]  __switch_to+0x8c/0xa8
[ 2499.461701]  update_process_times+0x2c/0x54
[ 2499.461702]  0xe
[ 2499.461704]  tick_sched_handle.isra.13+0x34/0x54
[ 2499.461704] Task dump for CPU 28:
[ 2499.461705]  tick_sched_timer+0x40/0x80
[ 2499.461706] swapper/28      R
[ 2499.461707]  __hrtimer_run_queues+0xdc/0x130
[ 2499.461707]   running task
[ 2499.461708]  hrtimer_interrupt+0x98/0x1cc
[ 2499.461709]     0     0      1 0x00000000
[ 2499.461711]  arch_timer_handler_phys+0x2c/0x38
[ 2499.461711] Call trace:
[ 2499.461713]  handle_percpu_devid_irq+0x78/0x120
[ 2499.461714]  __switch_to+0x8c/0xa8
[ 2499.461716]  generic_handle_irq+0x24/0x38
[ 2499.461717]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.461718]  __handle_domain_irq+0x60/0xb4
[ 2499.461719]            (null)
[ 2499.461720]  gic_handle_irq+0x98/0x1b0
[ 2499.461720] Task dump for CPU 29:
[ 2499.461721]  el1_irq+0xb0/0x140
[ 2499.461722] java            X
[ 2499.461723]  release_task+0x374/0x520
[ 2499.461723]   running task
[ 2499.461724]  do_exit+0x50c/0x9d0
[ 2499.461725]     0  4385      1 0x00000229
[ 2499.461726]  do_group_exit+0x38/0xa0
[ 2499.461726] Call trace:
[ 2499.461728]  get_signal+0x13c/0x444
[ 2499.461729]  __switch_to+0x8c/0xa8
[ 2499.461730]  do_signal+0x68/0x1c0
[ 2499.461731]  set_next_entity+0x3b0/0x5f8
[ 2499.461733]  do_notify_resume+0xcc/0x10c
[ 2499.461733]  0x33
[ 2499.461734]  work_pending+0x8/0x10
[ 2499.461735] Task dump for CPU 30:
[ 2499.461735] Task dump for CPU 13:
[ 2499.461736] java            X
[ 2499.461736] java            X
[ 2499.461737]   running task
[ 2499.461737]   running task
[ 2499.461738]     0  8678      1 0x00000229
[ 2499.461739]     0  4572      1 0x00000229
[ 2499.461739] Call trace:
[ 2499.461740] Call trace:
[ 2499.461741]  __switch_to+0x8c/0xa8
[ 2499.461742]  __switch_to+0x8c/0xa8
[ 2499.461743]  do_exit+0x2a4/0x9d0
[ 2499.461744]  set_next_entity+0x3b0/0x5f8
[ 2499.461745]  do_group_exit+0x38/0xa0
[ 2499.461746]  0x33
[ 2499.461747]  get_signal+0x13c/0x444
[ 2499.461747] Task dump for CPU 14:
[ 2499.461749]  do_signal+0x68/0x1c0
[ 2499.461749] java            X
[ 2499.461751]  do_notify_resume+0xcc/0x10c
[ 2499.461751]   running task
[ 2499.461752]  work_pending+0x8/0x10
[ 2499.461753]     0 10425      0 0x0000022a
[ 2499.461753] Task dump for CPU 31:
[ 2499.461754] Call trace:
[ 2499.461754] java            X
[ 2499.461755]  __switch_to+0x8c/0xa8
[ 2499.461756]   running task
[ 2499.461756]            (null)
[ 2499.461757]     0  4558      0 0x0000022a
[ 2499.461758]  do_group_exit+0x38/0xa0
[ 2499.461759] Call trace:
[ 2499.461760]  get_signal+0x13c/0x444
[ 2499.461761]  dump_backtrace+0x0/0x178
[ 2499.461762]  do_signal+0x68/0x1c0
[ 2499.461764]  show_stack+0x14/0x1c
[ 2499.461765]  do_notify_resume+0xcc/0x10c
[ 2499.461767]  sched_show_task+0x120/0x138
[ 2499.461768]  work_pending+0x8/0x10
[ 2499.461769]  dump_cpu_task+0x40/0x4c
[ 2499.461769] Task dump for CPU 15:
[ 2499.461770]  rcu_dump_cpu_stacks+0xa4/0xe4
[ 2499.461771] java            X
[ 2499.461772]  rcu_check_callbacks+0x760/0x970
[ 2499.461772]   running task
[ 2499.461774]  update_process_times+0x2c/0x54
[ 2499.461775]     0  8654      0 0x00000228
[ 2499.461776]  tick_sched_handle.isra.13+0x34/0x54
[ 2499.461776] Call trace:
[ 2499.461777]  tick_sched_timer+0x40/0x80
[ 2499.461779]  __switch_to+0x8c/0xa8
[ 2499.461780]  __hrtimer_run_queues+0xdc/0x130
[ 2499.461780]            (null)
[ 2499.461781]  hrtimer_interrupt+0x98/0x1cc
[ 2499.461782]  do_group_exit+0x38/0xa0
[ 2499.461784]  arch_timer_handler_phys+0x2c/0x38
[ 2499.461785]  get_signal+0x13c/0x444
[ 2499.461786]  handle_percpu_devid_irq+0x78/0x120
[ 2499.461788]  do_signal+0x68/0x1c0
[ 2499.461789]  generic_handle_irq+0x24/0x38
[ 2499.461790]  do_notify_resume+0xcc/0x10c
[ 2499.461792]  __handle_domain_irq+0x60/0xb4
[ 2499.461793]  work_pending+0x8/0x10
[ 2499.461794]  gic_handle_irq+0x98/0x1b0
[ 2499.461794] Task dump for CPU 0:
[ 2499.461795]  el1_irq+0xb0/0x140
[ 2499.461796] java            X
[ 2499.461797]  release_task+0x374/0x520
[ 2499.461798]   running task
[ 2499.461799]  do_exit+0x50c/0x9d0
[ 2499.461800]     0  6128      1 0x0000022b
[ 2499.461801]  do_group_exit+0x38/0xa0
[ 2499.461801] Call trace:
[ 2499.461802]  get_signal+0x13c/0x444
[ 2499.461804]  __switch_to+0x8c/0xa8
[ 2499.461805]  do_signal+0x68/0x1c0
[ 2499.461807]  set_next_entity+0x3b0/0x5f8
[ 2499.461808]  do_notify_resume+0xcc/0x10c
[ 2499.461809]  0x33
[ 2499.461810]  work_pending+0x8/0x10
[ 2499.461810] Task dump for CPU 1:
[ 2499.461811] Task dump for CPU 16:
[ 2499.461811] java            X
[ 2499.461812] java            X
[ 2499.461813]   running task
[ 2499.461813]   running task
[ 2499.461814]     0  4461      0 0x0000022a
[ 2499.461815]     0  4580      0 0x00000228
[ 2499.461815] Call trace:
[ 2499.461816] Call trace:
[ 2499.461817]  __switch_to+0x8c/0xa8
[ 2499.461818]  __switch_to+0x8c/0xa8
[ 2499.461819]  0xe
[ 2499.461819]  0xe
[ 2499.461820] Task dump for CPU 2:
[ 2499.461820] Task dump for CPU 17:
[ 2499.461821] sh              R
[ 2499.461821] java            X
[ 2499.461822]   running task
[ 2499.461822]   running task
[ 2499.461823]     0 14810   1402 0x00000200
[ 2499.461824]     0  4538      1 0x00000229
[ 2499.461824] Call trace:
[ 2499.461825] Call trace:
[ 2499.461826]  ret_from_fork+0x0/0x18
[ 2499.461827]  __switch_to+0x8c/0xa8
[ 2499.461827] Task dump for CPU 3:
[ 2499.461829]  set_next_entity+0x3b0/0x5f8
[ 2499.461829] java            X
[ 2499.461830]  0x33
[ 2499.461830]   running task
[ 2499.461831] Task dump for CPU 18:
[ 2499.461831]     0  7041      0 0x0000022a
[ 2499.461832] abrt-hook-ccpp  R
[ 2499.461832] Call trace:
[ 2499.461833]   running task
[ 2499.461834]  __switch_to+0x8c/0xa8
[ 2499.461835]     0 14811      2 0x00000200
[ 2499.461835]  0xe
[ 2499.461836] Call trace:
[ 2499.461836] Task dump for CPU 4:
[ 2499.461837]  ret_from_fork+0x0/0x18
[ 2499.461838] java            X
[ 2499.461838] Task dump for CPU 19:
[ 2499.461839]   running task
[ 2499.461839] java            X
[ 2499.461840]     0  4660      0 0x00000228
[ 2499.461841]   running task
[ 2499.461841] Call trace:
[ 2499.461842]     0  6708      1 0x00000229
[ 2499.461843]  __switch_to+0x8c/0xa8
[ 2499.461843] Call trace:
[ 2499.461844]  0xe
[ 2499.461845]  __switch_to+0x8c/0xa8
[ 2499.461846] Task dump for CPU 5:
[ 2499.461847]  do_exit+0x2a4/0x9d0
[ 2499.461847] java            X
[ 2499.461848]  do_group_exit+0x38/0xa0
[ 2499.461849]   running task
[ 2499.461850]  get_signal+0x13c/0x444
[ 2499.461850]     0  4546      1 0x00000229
[ 2499.461852]  do_signal+0x68/0x1c0
[ 2499.461852] Call trace:
[ 2499.461853]  do_notify_resume+0xcc/0x10c
[ 2499.461855]  __switch_to+0x8c/0xa8
[ 2499.461856]  work_pending+0x8/0x10
[ 2499.461857]  set_next_entity+0x3b0/0x5f8
[ 2499.461857] Task dump for CPU 20:
[ 2499.461858]  0x33
[ 2499.461858] java            X
[ 2499.461859] Task dump for CPU 6:
[ 2499.461859]   running task
[ 2499.461860] java            R
[ 2499.461861]     0 10449      1 0x00000221
[ 2499.461861]   running task
[ 2499.461862] Call trace:
[ 2499.461863]     0  3441      1 0x00000229
[ 2499.461864]  __switch_to+0x8c/0xa8
[ 2499.461864] Call trace:
[ 2499.461865]  do_exit+0x2a4/0x9d0
[ 2499.461867]  __switch_to+0x8c/0xa8
[ 2499.461868]  do_group_exit+0x38/0xa0
[ 2499.461869]  free_pid+0x60/0x118
[ 2499.461870]  get_signal+0x13c/0x444
[ 2499.461871]  0xffff80bf365e2c00
[ 2499.461872]  do_signal+0x68/0x1c0
[ 2499.461873]  do_notify_resume+0xcc/0x10c
[ 2499.461874]  work_pending+0x8/0x10
[ 2499.461875] Task dump for CPU 7:
[ 2499.461875] Task dump for CPU 21:
[ 2499.461876] java            X
[ 2499.461876] java            X
[ 2499.461877]   running task
[ 2499.461877]   running task
[ 2499.461878]     0  4529      1 0x00000229
[ 2499.461879]     0  2465      0 0x0000022a
[ 2499.461879] Call trace:
[ 2499.461880] Call trace:
[ 2499.461881]  __switch_to+0x8c/0xa8
[ 2499.461882]  __switch_to+0x8c/0xa8
[ 2499.461883]  set_next_entity+0x3b0/0x5f8
[ 2499.461884]  0xe
[ 2499.461884]  0x33
[ 2499.461885] Task dump for CPU 22:
[ 2499.461885] Task dump for CPU 8:
[ 2499.461886] swapper/22      R
[ 2499.461886] java            X
[ 2499.461887]   running task
[ 2499.461887]   running task
[ 2499.461888]     0     0      1 0x00000000
[ 2499.461889]     0  4577      1 0x00000229
[ 2499.461889] Call trace:
[ 2499.461890] Call trace:
[ 2499.461891]  __switch_to+0x8c/0xa8
[ 2499.461892]  __switch_to+0x8c/0xa8
[ 2499.461893]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.461894]  set_next_entity+0x3b0/0x5f8
[ 2499.461895]            (null)
[ 2499.461896]  0x33
[ 2499.461896] Task dump for CPU 23:
[ 2499.461896] Task dump for CPU 9:
[ 2499.461897] java            X
[ 2499.461898] java            X
[ 2499.461898]   running task
[ 2499.461898]   running task
[ 2499.461899]     0  4627      1 0x00000229
[ 2499.461900]     0  6979      1 0x00000229
[ 2499.461900] Call trace:
[ 2499.461901] Call trace:
[ 2499.461902]  __switch_to+0x8c/0xa8
[ 2499.461903]  __switch_to+0x8c/0xa8
[ 2499.461904]  set_next_entity+0x3b0/0x5f8
[ 2499.461905]  set_next_entity+0x3b0/0x5f8
[ 2499.461906]  0x33
[ 2499.461907]  0x33
[ 2499.461907] Task dump for CPU 24:
[ 2499.461907] Task dump for CPU 10:
[ 2499.461908] java            X
[ 2499.461909] stop-cassandra. S
[ 2499.461909]   running task
[ 2499.461910]     0 14808  14764 0x00000208
[ 2499.461911]     0  4703      1 0x0000022b
[ 2499.461911] Call trace:
[ 2499.461911] Call trace:
[ 2499.461913]  __switch_to+0x8c/0xa8
[ 2499.461914]  __switch_to+0x8c/0xa8
[ 2499.461915]  0xffff00004bd2fd90
[ 2499.461916]  set_next_entity+0x3b0/0x5f8
[ 2499.461916] Task dump for CPU 11:
[ 2499.461917]  0x33
[ 2499.461917] java            X
[ 2499.461918] Task dump for CPU 25:
[ 2499.461918]   running task
[ 2499.461919] swapper/25      R
[ 2499.461920]     0  2496      1 0x00000229
[ 2499.461920]   running task
[ 2499.461920] Call trace:
[ 2499.461921]     0     0      1 0x00000000
[ 2499.461922]  __switch_to+0x8c/0xa8
[ 2499.461923] Call trace:
[ 2499.461924]  set_next_entity+0x3b0/0x5f8
[ 2499.461925]  __switch_to+0x8c/0xa8
[ 2499.461926]  0x33
[ 2499.461927]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.461927] Task dump for CPU 12:
[ 2499.461928]            (null)
[ 2499.461928] java            X
[ 2499.461929] Task dump for CPU 26:
[ 2499.461929]   running task
[ 2499.461930] swapper/26      R
[ 2499.461931]     0  4586      0 0x0000022a
[ 2499.461931]   running task
[ 2499.461931] Call trace:
[ 2499.461932]     0     0      1 0x00000000
[ 2499.461933]  __switch_to+0x8c/0xa8
[ 2499.461934] Call trace:
[ 2499.461934]  0xe
[ 2499.461936]  __switch_to+0x8c/0xa8
[ 2499.461936] Task dump for CPU 13:
[ 2499.461937]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.461938] java            X
[ 2499.461938]            (null)
[ 2499.461938]   running task
[ 2499.461939] Task dump for CPU 27:
[ 2499.461940]     0  4572      1 0x00000229
[ 2499.461940] java            X
[ 2499.461941] Call trace:
[ 2499.461941]   running task
[ 2499.461942]  __switch_to+0x8c/0xa8
[ 2499.461943]     0  4954      0 0x00000228
[ 2499.461944]  set_next_entity+0x3b0/0x5f8
[ 2499.461944] Call trace:
[ 2499.461945]  0x33
[ 2499.461946]  __switch_to+0x8c/0xa8
[ 2499.461947] Task dump for CPU 14:
[ 2499.461947]  0xe
[ 2499.461948] java            X
[ 2499.461948] Task dump for CPU 28:
[ 2499.461949]   running task
[ 2499.461949] swapper/28      R
[ 2499.461950]     0 10425      0 0x0000022a
[ 2499.461950]   running task
[ 2499.461951] Call trace:
[ 2499.461952]     0     0      1 0x00000000
[ 2499.461953]  __switch_to+0x8c/0xa8
[ 2499.461953] Call trace:
[ 2499.461954]            (null)
[ 2499.461955]  __switch_to+0x8c/0xa8
[ 2499.461956]  do_group_exit+0x38/0xa0
[ 2499.461957]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.461959]  get_signal+0x13c/0x444
[ 2499.461959]            (null)
[ 2499.461960]  do_signal+0x68/0x1c0
[ 2499.461961] Task dump for CPU 29:
[ 2499.461962]  do_notify_resume+0xcc/0x10c
[ 2499.461963] java            X
[ 2499.461964]  work_pending+0x8/0x10
[ 2499.461964]   running task
[ 2499.461965] Task dump for CPU 15:
[ 2499.461966]     0  4385      1 0x00000229
[ 2499.461966] java            X
[ 2499.461967] Call trace:
[ 2499.461967]   running task
[ 2499.461968]  __switch_to+0x8c/0xa8
[ 2499.461969]     0  8654      0 0x00000228
[ 2499.461970]  set_next_entity+0x3b0/0x5f8
[ 2499.461971] Call trace:
[ 2499.461971]  0x33
[ 2499.461973]  __switch_to+0x8c/0xa8
[ 2499.461973] Task dump for CPU 30:
[ 2499.461974]            (null)
[ 2499.461974] java            X
[ 2499.461975]  do_group_exit+0x38/0xa0
[ 2499.461976]   running task
[ 2499.461977]  get_signal+0x13c/0x444
[ 2499.461978]     0  8678      1 0x00000229
[ 2499.461979]  do_signal+0x68/0x1c0
[ 2499.461979] Call trace:
[ 2499.461981]  do_notify_resume+0xcc/0x10c
[ 2499.461982]  __switch_to+0x8c/0xa8
[ 2499.461983]  work_pending+0x8/0x10
[ 2499.461984]  do_exit+0x2a4/0x9d0
[ 2499.461984] Task dump for CPU 0:
[ 2499.461985]  do_group_exit+0x38/0xa0
[ 2499.461986] java            X
[ 2499.461987]  get_signal+0x13c/0x444
[ 2499.461987]   running task
[ 2499.461989]  do_signal+0x68/0x1c0
[ 2499.461989]     0  6128      1 0x0000022b
[ 2499.461991]  do_notify_resume+0xcc/0x10c
[ 2499.461991] Call trace:
[ 2499.461992]  work_pending+0x8/0x10
[ 2499.461993]  __switch_to+0x8c/0xa8
[ 2499.461994] Task dump for CPU 31:
[ 2499.461995]  set_next_entity+0x3b0/0x5f8
[ 2499.461995] java            X
[ 2499.461996]  0x33
[ 2499.461996]   running task
[ 2499.461997] Task dump for CPU 1:
[ 2499.461997]     0  4558      0 0x0000022a
[ 2499.461998] java            X
[ 2499.461998] Call trace:
[ 2499.461998]   running task
[ 2499.462000]  __switch_to+0x8c/0xa8
[ 2499.462000]     0  4461      0 0x0000022a
[ 2499.462001]  0xe
[ 2499.462001] Call trace:
[ 2499.462002]  __switch_to+0x8c/0xa8
[ 2499.462003] Task dump for CPU 16:
[ 2499.462003]  0xe
[ 2499.462004] java            X
[ 2499.462005] Task dump for CPU 2:
[ 2499.462005]   running task
[ 2499.462006] swapper/2       R
[ 2499.462007]     0  4580      0 0x00000228
[ 2499.462007]   running task
[ 2499.462008] Call trace:
[ 2499.462009]     0     0      1 0x00000000
[ 2499.462010]  __switch_to+0x8c/0xa8
[ 2499.462010] Call trace:
[ 2499.462011]  0xe
[ 2499.462012]  __switch_to+0x8c/0xa8
[ 2499.462013] Task dump for CPU 17:
[ 2499.462014]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.462014] java            X
[ 2499.462015]            (null)
[ 2499.462015]   running task
[ 2499.462016] Task dump for CPU 3:
[ 2499.462017]     0  4538      1 0x00000229
[ 2499.462017] java            X
[ 2499.462018] Call trace:
[ 2499.462018]   running task
[ 2499.462019]  __switch_to+0x8c/0xa8
[ 2499.462020]     0  7041      0 0x0000022a
[ 2499.462021]  set_next_entity+0x3b0/0x5f8
[ 2499.462022] Call trace:
[ 2499.462022]  0x33
[ 2499.462024]  __switch_to+0x8c/0xa8
[ 2499.462024] Task dump for CPU 18:
[ 2499.462025]  0xe
[ 2499.462025] abrt-hook-ccpp  R
[ 2499.462026] Task dump for CPU 4:
[ 2499.462026]   running task
[ 2499.462027] java            X
[ 2499.462028]     0 14811      2 0x00000200
[ 2499.462028]   running task
[ 2499.462029] Call trace:
[ 2499.462030]     0  4660      0 0x0000022a
[ 2499.462031]  ret_from_fork+0x0/0x18
[ 2499.462031] Call trace:
[ 2499.462032] Task dump for CPU 19:
[ 2499.462033]  __switch_to+0x8c/0xa8
[ 2499.462033] java            X
[ 2499.462034]  0xe
[ 2499.462034]   running task
[ 2499.462035] Task dump for CPU 5:
[ 2499.462036]     0  6708      1 0x00000229
[ 2499.462036] java            X
[ 2499.462037] Call trace:
[ 2499.462037]   running task
[ 2499.462039]  __switch_to+0x8c/0xa8
[ 2499.462040]     0  4546      1 0x00000229
[ 2499.462041]  do_exit+0x2a4/0x9d0
[ 2499.462041] Call trace:
[ 2499.462042]  do_group_exit+0x38/0xa0
[ 2499.462043]  __switch_to+0x8c/0xa8
[ 2499.462044]  get_signal+0x13c/0x444
[ 2499.462046]  set_next_entity+0x3b0/0x5f8
[ 2499.462047]  do_signal+0x68/0x1c0
[ 2499.462048]  0x33
[ 2499.462049]  do_notify_resume+0xcc/0x10c
[ 2499.462049] Task dump for CPU 6:
[ 2499.462050]  work_pending+0x8/0x10
[ 2499.462051] java            R
[ 2499.462051] Task dump for CPU 20:
[ 2499.462052]   running task
[ 2499.462052] java            X
[ 2499.462053]     0  6567      1 0x00000229
[ 2499.462054]   running task
[ 2499.462054] Call trace:
[ 2499.462055]     0 10449      1 0x00000221
[ 2499.462056]  __switch_to+0x8c/0xa8
[ 2499.462057] Call trace:
[ 2499.462057]  0x6929bbef0d794900
[ 2499.462058]  __switch_to+0x8c/0xa8
[ 2499.462059] Task dump for CPU 7:
[ 2499.462060]  do_exit+0x2a4/0x9d0
[ 2499.462060] java            X
[ 2499.462062]  do_group_exit+0x38/0xa0
[ 2499.462062]   running task
[ 2499.462063]  get_signal+0x13c/0x444
[ 2499.462064]     0  4529      1 0x00000229
[ 2499.462065]  do_signal+0x68/0x1c0
[ 2499.462065] Call trace:
[ 2499.462067]  do_notify_resume+0xcc/0x10c
[ 2499.462068]  __switch_to+0x8c/0xa8
[ 2499.462069]  work_pending+0x8/0x10
[ 2499.462070]  set_next_entity+0x3b0/0x5f8
[ 2499.462071] Task dump for CPU 21:
[ 2499.462071]  0x33
[ 2499.462072] java            X
[ 2499.462072] Task dump for CPU 8:
[ 2499.462072]   running task
[ 2499.462073] java            X
[ 2499.462074]     0  2465      0 0x0000022a
[ 2499.462074]   running task
[ 2499.462075] Call trace:
[ 2499.462076]     0  4577      1 0x00000229
[ 2499.462077]  dump_backtrace+0x0/0x178
[ 2499.462077] Call trace:
[ 2499.462079]  show_stack+0x14/0x1c
[ 2499.462080]  __switch_to+0x8c/0xa8
[ 2499.462082]  sched_show_task+0x120/0x138
[ 2499.462083]  set_next_entity+0x3b0/0x5f8
[ 2499.462084]  dump_cpu_task+0x40/0x4c
[ 2499.462084]  0x33
[ 2499.462086]  rcu_dump_cpu_stacks+0xa4/0xe4
[ 2499.462086] Task dump for CPU 9:
[ 2499.462088]  rcu_check_callbacks+0x760/0x970
[ 2499.462088] java            X
[ 2499.462089]  update_process_times+0x2c/0x54
[ 2499.462090]   running task
[ 2499.462091]  tick_sched_handle.isra.13+0x34/0x54
[ 2499.462092]     0  6979      1 0x00000229
[ 2499.462093]  tick_sched_timer+0x40/0x80
[ 2499.462094] Call trace:
[ 2499.462095]  __hrtimer_run_queues+0xdc/0x130
[ 2499.462096]  __switch_to+0x8c/0xa8
[ 2499.462097]  hrtimer_interrupt+0x98/0x1cc
[ 2499.462098]  set_next_entity+0x3b0/0x5f8
[ 2499.462100]  arch_timer_handler_phys+0x2c/0x38
[ 2499.462100]  0x33
[ 2499.462102]  handle_percpu_devid_irq+0x78/0x120
[ 2499.462102] Task dump for CPU 10:
[ 2499.462104]  generic_handle_irq+0x24/0x38
[ 2499.462104] stop-cassandra. S
[ 2499.462106]  __handle_domain_irq+0x60/0xb4
[ 2499.462107]     0 14808  14764 0x00000208
[ 2499.462108]  gic_handle_irq+0x98/0x1b0
[ 2499.462108] Call trace:
[ 2499.462109]  el1_irq+0xb0/0x140
[ 2499.462110]  __switch_to+0x8c/0xa8
[ 2499.462111]  release_task+0x374/0x520
[ 2499.462112]  0xffff00004bd2fd90
[ 2499.462113]  do_exit+0x50c/0x9d0
[ 2499.462114] Task dump for CPU 11:
[ 2499.462115]  do_group_exit+0x38/0xa0
[ 2499.462115] java            X
[ 2499.462116]  get_signal+0x13c/0x444
[ 2499.462116]   running task
[ 2499.462118]  do_signal+0x68/0x1c0
[ 2499.462119]     0  2496      1 0x00000229
[ 2499.462120]  do_notify_resume+0xcc/0x10c
[ 2499.462120] Call trace:
[ 2499.462121]  work_pending+0x8/0x10
[ 2499.462123]  __switch_to+0x8c/0xa8
[ 2499.462123] Task dump for CPU 22:
[ 2499.462124]  set_next_entity+0x3b0/0x5f8
[ 2499.462125] swapper/22      R
[ 2499.462125]  0x33
[ 2499.462126]   running task
[ 2499.462126] Task dump for CPU 12:
[ 2499.462127]     0     0      1 0x00000000
[ 2499.462128] java            X
[ 2499.462128] Call trace:
[ 2499.462128]   running task
[ 2499.462130]  __switch_to+0x8c/0xa8
[ 2499.462131]     0  4586      0 0x0000022a
[ 2499.462132]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.462132] Call trace:
[ 2499.462133]            (null)
[ 2499.462134]  __switch_to+0x8c/0xa8
[ 2499.462134] Task dump for CPU 23:
[ 2499.462135]  0xe
[ 2499.462135] java            X
[ 2499.462136] Task dump for CPU 13:
[ 2499.462136]   running task
[ 2499.462137] java            X
[ 2499.462138]     0  4627      1 0x00000229
[ 2499.462138]   running task
[ 2499.462139] Call trace:
[ 2499.462139]     0  4572      1 0x00000229
[ 2499.462141]  __switch_to+0x8c/0xa8
[ 2499.462141] Call trace:
[ 2499.462142]  set_next_entity+0x3b0/0x5f8
[ 2499.462144]  dump_backtrace+0x0/0x178
[ 2499.462144]  0x33
[ 2499.462146]  show_stack+0x14/0x1c
[ 2499.462146] Task dump for CPU 24:
[ 2499.462148]  sched_show_task+0x120/0x138
[ 2499.462148] java            X
[ 2499.462149]  dump_cpu_task+0x40/0x4c
[ 2499.462149]   running task
[ 2499.462151]  rcu_dump_cpu_stacks+0xa4/0xe4
[ 2499.462152]     0  4703      1 0x0000022b
[ 2499.462153]  rcu_check_callbacks+0x760/0x970
[ 2499.462154] Call trace:
[ 2499.462155]  update_process_times+0x2c/0x54
[ 2499.462156]  __switch_to+0x8c/0xa8
[ 2499.462157]  tick_sched_handle.isra.13+0x34/0x54
[ 2499.462158]  set_next_entity+0x3b0/0x5f8
[ 2499.462159]  tick_sched_timer+0x40/0x80
[ 2499.462160]  0x33
[ 2499.462161]  __hrtimer_run_queues+0xdc/0x130
[ 2499.462161] Task dump for CPU 25:
[ 2499.462162]  hrtimer_interrupt+0x98/0x1cc
[ 2499.462163] swapper/25      R
[ 2499.462164]  arch_timer_handler_phys+0x2c/0x38
[ 2499.462164]   running task
[ 2499.462166]  handle_percpu_devid_irq+0x78/0x120
[ 2499.462167]     0     0      1 0x00000000
[ 2499.462168]  generic_handle_irq+0x24/0x38
[ 2499.462169] Call trace:
[ 2499.462170]  __handle_domain_irq+0x60/0xb4
[ 2499.462171]  __switch_to+0x8c/0xa8
[ 2499.462172]  gic_handle_irq+0x98/0x1b0
[ 2499.462173]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.462174]  el1_irq+0xb0/0x140
[ 2499.462175]            (null)
[ 2499.462176]  do_exit+0x4b4/0x9d0
[ 2499.462176] Task dump for CPU 26:
[ 2499.462178]  do_group_exit+0x38/0xa0
[ 2499.462178] swapper/26      R
[ 2499.462179]  get_signal+0x13c/0x444
[ 2499.462179]   running task
[ 2499.462181]  do_signal+0x68/0x1c0
[ 2499.462182]     0     0      1 0x00000000
[ 2499.462183]  do_notify_resume+0xcc/0x10c
[ 2499.462183] Call trace:
[ 2499.462184]  work_pending+0x8/0x10
[ 2499.462186]  __switch_to+0x8c/0xa8
[ 2499.462186] Task dump for CPU 14:
[ 2499.462187]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.462188] java            X
[ 2499.462188]            (null)
[ 2499.462189]   running task
[ 2499.462189] Task dump for CPU 27:
[ 2499.462190]     0 10425      0 0x0000022a
[ 2499.462191] java            X
[ 2499.462191] Call trace:
[ 2499.462191]   running task
[ 2499.462193]  __switch_to+0x8c/0xa8
[ 2499.462193]     0  4954      0 0x00000228
[ 2499.462194]            (null)
[ 2499.462194] Call trace:
[ 2499.462195]  do_group_exit+0x38/0xa0
[ 2499.462196]  __switch_to+0x8c/0xa8
[ 2499.462197]  get_signal+0x13c/0x444
[ 2499.462198]  0xe
[ 2499.462199]  do_signal+0x68/0x1c0
[ 2499.462200] Task dump for CPU 28:
[ 2499.462201]  do_notify_resume+0xcc/0x10c
[ 2499.462201] swapper/28      R
[ 2499.462202]  work_pending+0x8/0x10
[ 2499.462203]   running task
[ 2499.462203] Task dump for CPU 15:
[ 2499.462204]     0     0      1 0x00000000
[ 2499.462205] java            X
[ 2499.462205] Call trace:
[ 2499.462205]   running task
[ 2499.462207]  __switch_to+0x8c/0xa8
[ 2499.462208]     0  8654      0 0x00000228
[ 2499.462209]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.462209] Call trace:
[ 2499.462210]            (null)
[ 2499.462211]  __switch_to+0x8c/0xa8
[ 2499.462212] Task dump for CPU 29:
[ 2499.462212]            (null)
[ 2499.462212] java            X
[ 2499.462214]  do_group_exit+0x38/0xa0
[ 2499.462214]   running task
[ 2499.462215]  get_signal+0x13c/0x444
[ 2499.462216]     0  4385      1 0x00000229
[ 2499.462217]  do_signal+0x68/0x1c0
[ 2499.462217] Call trace:
[ 2499.462219]  do_notify_resume+0xcc/0x10c
[ 2499.462220]  __switch_to+0x8c/0xa8
[ 2499.462221]  work_pending+0x8/0x10
[ 2499.462222]  set_next_entity+0x3b0/0x5f8
[ 2499.462223] Task dump for CPU 0:
[ 2499.462223]  0x33
[ 2499.462224] java            X
[ 2499.462225] Task dump for CPU 30:
[ 2499.462225]   running task
[ 2499.462226] java            X
[ 2499.462227]     0  6128      1 0x0000022b
[ 2499.462227]   running task
[ 2499.462228] Call trace:
[ 2499.462229]     0  8678      1 0x00000229
[ 2499.462231]  __switch_to+0x8c/0xa8
[ 2499.462231] Call trace:
[ 2499.462232]  set_next_entity+0x3b0/0x5f8
[ 2499.462234]  __switch_to+0x8c/0xa8
[ 2499.462235]  0x33
[ 2499.462236]  do_exit+0x2a4/0x9d0
[ 2499.462236] Task dump for CPU 1:
[ 2499.462237]  do_group_exit+0x38/0xa0
[ 2499.462238] java            X
[ 2499.462239]  get_signal+0x13c/0x444
[ 2499.462239]   running task
[ 2499.462241]  do_signal+0x68/0x1c0
[ 2499.462242]     0  4461      0 0x0000022a
[ 2499.462243]  do_notify_resume+0xcc/0x10c
[ 2499.462243] Call trace:
[ 2499.462244]  work_pending+0x8/0x10
[ 2499.462246]  __switch_to+0x8c/0xa8
[ 2499.462246] Task dump for CPU 31:
[ 2499.462247]  0xe
[ 2499.462247] swapper/31      R
[ 2499.462248] Task dump for CPU 2:
[ 2499.462248]   running task
[ 2499.462249] swapper/2       R
[ 2499.462250]     0     0      1 0x00000000
[ 2499.462250]   running task
[ 2499.462251] Call trace:
[ 2499.462252]     0     0      1 0x00000000
[ 2499.462253]  __switch_to+0x8c/0xa8
[ 2499.462253] Call trace:
[ 2499.462255]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.462256]  __switch_to+0x8c/0xa8
[ 2499.462256]            (null)
[ 2499.462258]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.462259] Task dump for CPU 16:
[ 2499.462259]            (null)
[ 2499.462260] java            X
[ 2499.462260] Task dump for CPU 3:
[ 2499.462261]   running task
[ 2499.462261] java            X
[ 2499.462262]     0  4580      0 0x00000228
[ 2499.462262]   running task
[ 2499.462263] Call trace:
[ 2499.462264]     0  7041      0 0x0000022a
[ 2499.462265]  __switch_to+0x8c/0xa8
[ 2499.462265] Call trace:
[ 2499.462266]  0xe
[...]
[ 2499.464056] Task dump for CPU 5:
[ 2499.464057]  __switch_to+0x8c/0xa8
[ 2499.464057] java            X
[ 2499.464059]  __tick_nohz_idle_enter+0xc0/0x1b0
[ 2499.464059]   running task
[ 2499.464060]            (null)
[ 2499.464061]     0  4546      1 0x00000229
[ 2499.464061] Task dump for CPU 31:
[ 2499.464062] Call trace:
[ 2499.464062] swapper/31      R
...
[ 2524.030829] Call trace:
[ 2524.033267]  dump_backtrace+0x0/0x178
[ 2524.036917]  show_stack+0x14/0x1c
[ 2524.040220]  sched_show_task+0x120/0x138
[ 2524.044130]  dump_cpu_task+0x40/0x4c
[ 2524.047692]  rcu_dump_cpu_stacks+0xa4/0xe4
[ 2524.051776]  rcu_check_callbacks+0x760/0x970
[ 2524.056033]  update_process_times+0x2c/0x54
[ 2524.060204]  tick_sched_handle.isra.13+0x34/0x54
[ 2524.064807]  tick_sched_timer+0x40/0x80
[ 2524.068630]  __hrtimer_run_queues+0xdc/0x130
[ 2524.072886]  hrtimer_interrupt+0x98/0x1cc
[ 2524.076884]  arch_timer_handler_phys+0x2c/0x38
[ 2524.081315]  handle_percpu_devid_irq+0x78/0x120
[ 2524.085833]  generic_handle_irq+0x24/0x38
[ 2524.089829]  __handle_domain_irq+0x60/0xb4
[ 2524.093912]  gic_handle_irq+0x98/0x1b0
[ 2524.097647]  el1_irq+0xb0/0x140
[ 2524.100776]  do_exit+0x4b4/0x9d0
[ 2524.103991]  do_group_exit+0x38/0xa0
[ 2524.107554]  get_signal+0x13c/0x444
[ 2524.111029]  do_signal+0x68/0x1c0
[ 2524.114331]  do_notify_resume+0xcc/0x10c
[ 2524.118240]  work_pending+0x8/0x10

On Thu, Apr 12, 2018 at 10:24 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Tai,
>
> On Thu, Apr 12, 2018 at 10:10:40AM -0700, Tai Tri Nguyen wrote:
>> Recently I have observed the CPU crashes/stalls when rebooting after I
>> ran cassandra benchmark.
>> The issue happens randomly.
>
> Please could you share some logs and more details about the crashes and
> stalls? At the moment there's not much we can do with this report :/
>
> Ideally, we'd have steps to reproduce the issue, but it seems that you
> don't have a reliable method for that.
>
> One other thing you could try is removing the WFE from our cmpwait
> implementation in case you have a CPU erratum in that area.
>
> Will



-- 
Tai
