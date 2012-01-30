From: eranian@googlemail.com (stephane eranian)
Date: Mon, 30 Jan 2012 18:15:53 +0100
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <yw1xsjixgolb.fsf@unicorn.mansr.com>
References: <CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
 <20120127121311.GB2347@mudshark.cambridge.arm.com>
 <yw1x1uqlnw1o.fsf@unicorn.mansr.com>
 <20120127132826.GD2347@mudshark.cambridge.arm.com>
 <CACVXFVPHpmPX9OdeYzzWjQ-qqs=9oYbL_og-_xJA2ypYNu0nRA@mail.gmail.com>
 <CAMsRxfJOAh1V7sMWxqCXADDB_eSAuxop1iYAGqXvLC_74Pfz1A@mail.gmail.com>
 <20120127155454.GH2347@mudshark.cambridge.arm.com>
 <CAMsRxfK-SFEyP5+jyXDyWSQPJ2KO_1YQM_yZdtwV0NJu+idqHA@mail.gmail.com>
 <20120127165941.GK2347@mudshark.cambridge.arm.com>
 <CAMsRxf+iv06zOCMzhYONeLaf6RvOLp38T53mR--8ESHvCXMeFQ@mail.gmail.com>
 <20120127171009.GL2347@mudshark.cambridge.arm.com>
 <CAMsRxfJufRMrcfGZp53ALOdEFLk+YDMvQMrHw-jR9tQ8ThE+-Q@mail.gmail.com>
 <CAMsRxfK5tv1DZmHH4F0BT+zVUboESiMmCkatO2NLHp03=e51fQ@mail.gmail.com>
 <CACVXFVMgDpaYeaU+0LGirYzNfJb8k0wFfL=+UU5qAwYfXgWLMQ@mail.gmail.com>
 <CAMsRxfJq1-tSQH4bv0BeNWXV9aysi9AUvywkh3e9SaamMDfZ0Q@mail.gmail.com>
 <CAMsRxf+okps60OxQnPkqHck8pWHrkPnT6boo603pC2XEbFYoRQ@mail.gmail.com>
 <CACVXFVMDXO3DDj0mGh=+uDYfCoS_Ck1STVK0=UXjiAbtJTa=hA@mail.gmail.com>
 <CAMsRxfLqvPN_k7vuC3qzBjwX2ihBdPxZvmSCPZ3frWgptWXQGA@mail.gmail.com>
 <yw1xsjixgolb.fsf@unicorn.mansr.com>
Message-ID: <CAMsRxfJLsnBnKBrEXOSOWUTbgfeZtVZ6nR8jt388=baL5Mn22Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 5:08 PM, M?ns Rullg?rd <mans@mansr.com> wrote:
> stephane eranian <eranian@googlemail.com> writes:
>
>> Same result for me on CPU1:
>>
>> top - 16:20:24 up ?1:45, ?1 user, ?load average: 0.29, 0.08, 0.07
>> Tasks: ?70 total, ? 2 running, ?68 sleeping, ? 0 stopped, ? 0 zombie
>> Cpu(s): 30.7%us, ?2.7%sy, ?0.0%ni, 66.7%id, ?0.0%wa, ?0.0%hi, ?0.0%si, ?0.0%st
>> Mem: ? ?940232k total, ? 228984k used, ? 711248k free, ? ?82244k buffers
>> Swap: ? 524240k total, ? ? ? ?0k used, ? 524240k free, ? ?91400k cached
>>
>> ? PID USER ? ? ?PR ?NI ?VIRT ?RES ?SHR S %CPU %MEM ? ?TIME+ ?P COMMAND
>> ?3968 eranian ? 20 ? 0 ? 644 ?160 ?128 R ?100 ?0.0 ? 0:21.98 1 noploop
>> ?3969 eranian ? 20 ? 0 ?2184 1056 ?804 R ? ?3 ?0.1 ? 0:00.53 0 top
>> ? ?82 root ? ? ?20 ? 0 ? ? 0 ? ?0 ? ?0 S ? ?1 ?0.0 ? 0:01.35 0
>> kworker/0:1
>>
>> With 3.3.0-rc1, if I revert the clockdomain patch, I get the same result.
>> So it must be coming from somewhere else, as you suggested.
>>
>> If the processor was spending time processing interrupts, then this would be
>> accounted for in as sys time. But that's not what I observe here. It's either
>> idle or user. That line, leads me to believe that the processor can only run
>> my program for 30% of the time. The rest is spent idling even though my
>> program is non-blocking. How could that be possible? Power-saving?
>
> In top, press 1 to see the statistics for the CPUs separately.
>
Ok, when I pin my program to CPU1, and press 1 in top I get:
asks:  69 total,   2 running,  67 sleeping,   0 stopped,   0 zombie
Cpu0  :  0.9%us,  3.8%sy,  0.0%ni, 94.3%id,  0.0%wa,  0.0%hi,  0.9%si,  0.0%st
Cpu1  :100.0%us,  0.0%sy,  0.0%ni,  0.0%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:    940232k total,    75480k used,   864752k free,     8148k buffers
Swap:   524240k total,        0k used,   524240k free,    37568k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 3788 eranian   20   0   644  160  128 R  100  0.0   0:47.93 noploop
 3758 eranian   20   0  9900 1512  712 S    2  0.2   0:01.17 sshd
 3789 eranian   20   0  2184 1056  804 R    2  0.1   0:01.22 top

Which gives me the right answer. But in 'collapsed mode', press 1 again,
the aggregate value is bogus. Could be wrong math in top. Ok, that was
a false alarm then. Thanks for the help.

Still need to investigate why the frequency mode does
not yield the correct number of samples even with low frequency.


$ taskset -c 1 perf record -e cycles -F 100 noploop 10
$ perf report -D | tail -20
Aggregated stats:
           TOTAL events:        475
            MMAP events:         11
            COMM events:          2
            EXIT events:          2
          SAMPLE events:        460
cycles stats:
           TOTAL events:        475
            MMAP events:         11
            COMM events:          2
            EXIT events:          2
          SAMPLE events:        460

460 samples is way too low. Should be 100x10 = 1000 samples or close to it.
