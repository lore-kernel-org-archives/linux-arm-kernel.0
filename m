From: wuqixuan@gmail.com (qixuan wu)
Date: Sat, 5 Apr 2014 13:41:17 +0800
Subject: Help for doubt about why update SCTLR by cr_alignment every
 syscall,IRQ,exception ?
Message-ID: <CAEjEV8DLk5fhQHMomrrO3h+_9=yo3pMiEvjXG7nOydJOWdf7zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear King, all,

If we enable CONFIG_ALIGNMENT_TRAP:

1. I don't know why each syscall and user_entry for IRQ or exception,
need update SCTLR using cr_alignment.
(below code is from kernel 3.10.18 for ARM SMP)

1) First scenario, each syscall will reset the SCTLR
   using cr_alignment.

ENTRY(vector_swi)
  ....

#ifdef CONFIG_ALIGNMENT_TRAP
    ldr    ip, __cr_alignment
    ldr    ip, [ip]
    mcr    p15, 0, ip, c1, c0      @ update SCTLR
#endif
  ....
ENDPROC(vector_swi)

2) Second scenario, each IRQ or exception to the user space,
   will reset the SCTLR using cr_alignment.

    .macro    usr_entry
  ....
    @ Enable the alignment trap while in kernel mode
    alignment_trap r0    @ ******** Here is a macro which will update
SCTLR *********
  ....
    .endm

2. Actually, I search in the code, SCTLR is initialized during
system init in some place, after that only do_alignment()
will change the value to cr_no_alignment, but cr_no_alignment
seems like always be same as cr_alignment.

static int __init alignment_init(void) {
...
        cr_alignment &= ~CR_A;
        cr_no_alignment &= ~CR_A;
        set_cr(cr_alignment);
...
}

In some case:
static int __init early_cachepolicy(char *p){
....
    cr_alignment &= ~cache_policies[i].cr_mask;
    cr_no_alignment &= ~cache_policies[i].cr_mask;
....
    set_cr(cr_alignment);
}

do_alignment(){
...
    set_cr(cr_no_alignment);
...
}

3. That means after system init, SCTLR will not be changed.

So is there anyone who has idea about:

1) Why need update SCTLR on above two scenarios?
2) If I remove the updation on above two scenarios, is there
any risk ?

Any comments is welcome and helpful.

Regards and Thanks a lot,
Wuqixuan.
