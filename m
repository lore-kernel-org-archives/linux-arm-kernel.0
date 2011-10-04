From: hgu1972@gmail.com (Harald Gustafsson)
Date: Tue, 4 Oct 2011 14:52:28 +0200
Subject: unwind and lockdep
Message-ID: <CAC3jWv+phJoEpBKexf3FUyFgXVQwPY_YyqCOrW3jq86CqVViow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have turned on lockdep on a 2.6.35.7 kernel compiled for mach-ux500
arch with ARM_UNWIND and get some unwind Index not found warnings,
especially during the boot.  E.g. the following, see warnings at end:
 <7>[  134.874481] unwind_frame(pc = c033abf0 lr = c033abf0 sp = c06d1fa0)
<7>[  134.874481] unwind_find_idx(c033abf0)
<7>[  134.874511] search_index(c033abf0, c06ae000->addr=c002c968, c06cccd8)
<7>[  134.874542] unwind_find_idx: idx = c06c3488
<7>[  134.874542] unwind_exec_insn: insn = 00000084
<7>[  134.874572] unwind_exec_insn: fp = 00000000 sp = c06d1fc0 lr =
c003b6f8 pc = 00000000
<7>[  134.874603] unwind_exec_insn: insn = 000000b0
<7>[  134.874603] unwind_exec_insn: fp = 00000000 sp = c06d1fc0 lr =
c003b6f8 pc = c003b6f8
<7>[  134.874633] unwind_frame(pc = c003b6f8 lr = c003b6f8 sp = c06d1fc0)
<7>[  134.874664] unwind_find_idx(c003b6f8)
<7>[  134.874694] search_index(c003b6f8, c06ae000->addr=c002c968, c06cccd8)
<7>[  134.874694] unwind_find_idx: idx = c06af6b0
<7>[  134.874725] unwind_exec_insn: insn = 000000ac
<7>[  134.874755] unwind_exec_insn: fp = 00000000 sp = c06d1fd8 lr =
c0008b70 pc = 00000000
<7>[  134.874755] unwind_exec_insn: insn = 000000b0
<7>[  134.874786] unwind_exec_insn: fp = 00000000 sp = c06d1fd8 lr =
c0008b70 pc = c0008b70
<7>[  134.874816] unwind_frame(pc = c0008b70 lr = c0008b70 sp = c06d1fd8)
<7>[  134.874816] unwind_find_idx(c0008b70)
<7>[  134.874847] search_index(c0008b70, c06ae000->addr=c002c968, c06cccd8)
<4>[  134.874877] unwind: Unknown symbol address c0008b70
<7>[  134.879760] unwind_find_idx: idx = (null)
<4>[  134.879791] unwind: Index not found c0008b70

(Where I changed the debug print to also show the addr in the "first"
entry for search_index)

The address c0008b70 is within the addresses that core_kernel_text
checks for (c0008000-c06ae000) and also within init_kernel_text checks
(c0008000-c002c968).
But why is then search_index checking if it is below c002c968 and
bails out if it is?

Anyone that could give me some hints about this? Is this expected?

/Harald
