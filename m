From: miloody@gmail.com (loody)
Date: Tue, 20 Nov 2012 01:31:13 +0800
Subject: some question about arm kernel
Message-ID: <CANudz+tidxT-RXuSbh2Coi2aZLHCq12m_t6n-R0_MQkQ5mDg8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi all:
i have 2 questions about arm kernel.
1. is below code duplicated?

         /*
         * Create identity mapping to cater for __enable_mmu.
         * This identity mapping will be removed by paging_init().
         */
        adr     r0, __turn_mmu_on_loc
        ldmia   r0, {r3, r5, r6}
        sub     r0, r0, r3                      @ virt->phys offset
        add     r5, r5, r0                      @ phys __turn_mmu_on
        add     r6, r6, r0                      @ phys __turn_mmu_on_end
        mov     r5, r5, lsr #SECTION_SHIFT
        mov     r6, r6, lsr #SECTION_SHIFT

1:      orr     r3, r7, r5, lsl #SECTION_SHIFT  @ flags + kernel base
        str     r3, [r4, r5, lsl #PMD_ORDER]    @ identity mapping
        cmp     r5, r6
        addlo   r5, r5, #1                      @ next section
        blo     1b


Since later building kernel direct mapped region, __turn_mmu_on will
re-calculated and fill in page table again.
Why we specially create identity mapping for __turn_mmu_on?

2. for multi-core, cortex a9 for example, which function is the other
CPUs' entry point?
or all other cpus will go through the same head.S again?

Thanks for your help in advance,
