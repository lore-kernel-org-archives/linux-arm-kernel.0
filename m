From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 3 Jul 2018 19:25:43 +0200
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180703163645.GA23144@redhat.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com>
 <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
 <20180703163645.GA23144@redhat.com>
Message-ID: <20180703172543.GC23144@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03, Oleg Nesterov wrote:
>
> In short. There is a 1:1 relationship between uprobe_write_opcode(is_register => 1)
> and install_breakpoint(), and between uprobe_write_opcode(is_register => 0) and
> remove_breakpoint(). Whatever uprobe_write_opcode() can do if is_register == 1 can be
> done in install_breakpoint(), the same for is_register == 0 and remove_breakpont().
>
> What have I missed?

Ah. I missed the fact that uprobe_write_opcode() doesn't do update_ref_ctr() if
verify_opcode() returns false.

Now I understand what did you mean by "for each consumer". So if we move this logic
into install/remove_breakpoint as I tried to suggest, we will also need another error
code for the case when verify_opcode() returns false.

Oleg.
