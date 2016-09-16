From: fweimer@redhat.com (Florian Weimer)
Date: Fri, 16 Sep 2016 14:10:53 +0200
Subject: [RFC PATCH 0/5] arm64: Signal context expansion
In-Reply-To: <20160915164543.GB1574@e103592.cambridge.arm.com>
References: <1473430576-20792-1-git-send-email-Dave.Martin@arm.com>
 <dad2e7cc-f8cb-4e33-99c7-66effa7a6f5e@redhat.com>
 <20160909152047.GA3958@e103592.cambridge.arm.com>
 <d7fa9069-f952-0642-9668-2fea640cdb20@redhat.com>
 <20160912111749.GB3958@e103592.cambridge.arm.com> <57D6C33D.9020003@arm.com>
 <20160912153015.GD3958@e103592.cambridge.arm.com>
 <9969568a-f969-d904-52b3-14f80c3abec4@redhat.com>
 <20160913155151.GA1574@e103592.cambridge.arm.com>
 <d2e8f4f5-1229-9733-174d-b3123c5e887b@redhat.com>
 <20160915164543.GB1574@e103592.cambridge.arm.com>
Message-ID: <ad89f920-897c-47cb-d584-4b306bc24d1c@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2016 06:45 PM, Dave Martin wrote:
> On Tue, Sep 13, 2016 at 06:02:45PM +0200, Florian Weimer wrote:
>> On 09/13/2016 05:52 PM, Dave Martin wrote:
>>
>>> Agreed.  I'll need to think some more about how this should work in
>>> general.
>>
>> Thanks.
>>
>> Depending on some SVE implementations details (which I know nothing about, I
>> only saw some public overview slides), we may also need additional storage
>> space to preserve SVE registers in the dynamic linker.  Due to lazy binding,
>> this code cn be called from a signal handler, so this needs to be factored
>> into stack size requirements as well.
>
> Yes and no.  The kernel SIGSTKSZ constants don't care about ld.so --
> that's userspace overhead, not kernel overhead.

Well yes, so is jmp_buf.  But I think you still should consider the full 
picture. :)

At least the lazy binding stack overhead can be avoided with LD_BIND_NOW=1.

>> Problematic are register width extensions used for argument passing and
>> callee-saved registers whose width has been extended.  Both are particularly
>> challenging to deal with if existing vector instructions clear the extension
>> part (which may be desirable for other reasons).
>>
>> The size of the jmp_buf type is a concern as well.
>
> The default PCS for SVE will not be introducing any extra save/restore
> requirements for SVE -- i.e., everything is caller-save at public
> interfaces, except for the FPSIMD register bits that are already callee-
> save under the existing PCS.

Is it possible to pass arguments in the register extension parts?  If 
existing non-SVE code can clobber these bits, we need some adjustments 
in libc to save and restore SVE state in some places (which may need 
further stack space).

Again, for lazy binding, LD_BIND_NOW=1 will help temporarily, but 
profiling code may need a separate fix.

Thanks,
Florian
