From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Mon, 16 Jul 2018 13:50:10 +0530
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <CAPhsuW5njYcYXxYYEUsdVWem3qwk2z_bra_eRpwHwEy9TA-LHQ@mail.gmail.com>
References: <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com>
 <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
 <20180703163645.GA23144@redhat.com> <20180703172543.GC23144@redhat.com>
 <f5a39a88-c21e-4606-a04d-11b5f32016b8@linux.ibm.com>
 <20180710152527.GA3616@redhat.com>
 <6e3ff60b-267a-d49d-4ebb-c4264f9c034b@linux.ibm.com>
 <20180712145849.GB15265@redhat.com>
 <CAPhsuW6kCtn-tWSj5eKf+kGt8ZEjVwJKLxj9C6zdaqMZByRytg@mail.gmail.com>
 <9b062a19-d9a7-b360-26b1-d28b8dfc35a3@linux.ibm.com>
 <CAPhsuW5njYcYXxYYEUsdVWem3qwk2z_bra_eRpwHwEy9TA-LHQ@mail.gmail.com>
Message-ID: <a37cc94b-5940-643c-3e81-fc375c6aada0@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Song,

On 07/14/2018 05:20 AM, Song Liu wrote:
> 
> Hmm... what happens when we have multiple uprobes sharing the same
> reference counter? It feels equally complicate to me. Or did I miss any
> cases here?


As far as I can think of, it should be handled by default. No special
treatment needed for this.

...

> 
> This patch tries to resolve this imbalance by passing extra flag
> "restore_insn" to probe_event_disable().
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>


Ah cool. Seems this will make them balanced. But is it fine to change
uprobe_unregister()? It's already an ABI. No other way around?

Also, one more source of imbalance is this condition:

          if (is_register)
                  flags |= VM_WRITE;

in valid_vma(). You need to take care of that as well.

Thanks,
Ravi
