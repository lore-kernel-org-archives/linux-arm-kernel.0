From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Thu, 27 Mar 2014 13:29:10 -0400
Subject: [PATCH v2 3/3] ARM: Check if a CPU has gone offline
In-Reply-To: <CABGGisxdp88NW_SMxbfDuv1fyp-YtcTbhQLLfMmbNkgdJNHKVA@mail.gmail.com>
References: <1395934715-31348-1-git-send-email-ashwin.chaugule@linaro.org>
 <1395934715-31348-3-git-send-email-ashwin.chaugule@linaro.org>
 <CABGGisxdp88NW_SMxbfDuv1fyp-YtcTbhQLLfMmbNkgdJNHKVA@mail.gmail.com>
Message-ID: <CAJ5Y-eaA8C_RW3WgHFG9QvxZmmyO8U=9HsZTUXmv_nNtoTEk7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 March 2014 12:52, Rob Herring <rob.herring@linaro.org> wrote:
> On Thu, Mar 27, 2014 at 10:38 AM, Ashwin Chaugule

>> +
>> +int __ref psci_cpu_kill(unsigned int cpu)
>> +{
>> +       int err = 0;
>> +
>> +       if (psci_ops.affinity_info) {
>
> You can save a level of indentation with:
>
> if (!psci_ops.affinity_info)
>     return 1;
>
> This fixes the return as no affinity_info call (i.e. 0.1 PSCI) should not fail.
>
>> +               err = psci_ops.affinity_info(cpu, 0);
>
> You need to convert the logical cpu (0..N) to the mpidr value (cpu_logical_map).

Gah. Thanks. That "aff" stuff is confusing.

>
>> +
>> +               if (err != 1) {
>
> 1 should have a define (in the uapi header).
>
> Which reminds me, all the PSCI return code defines should also be in
> that header.

Makes sense.

Thanks,
Ashwin
