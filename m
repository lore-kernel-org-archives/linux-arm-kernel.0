From: fweimer@redhat.com (Florian Weimer)
Date: Mon, 5 Dec 2016 11:44:38 +0100
Subject: [RFC PATCH 00/29] arm64: Scalable Vector Extension core support
In-Reply-To: <20161201103048.GO1574@e103592.cambridge.arm.com>
References: <20161130120654.GJ1574@e103592.cambridge.arm.com>
 <3e8afc5a-1ba9-6369-462b-4f5a707d8b8a@redhat.com>
 <20161130135631.GK1574@e103592.cambridge.arm.com>
 <dbcd545f-1358-6a80-5a9f-3e4a3c93189a@redhat.com>
 <20161201103048.GO1574@e103592.cambridge.arm.com>
Message-ID: <0293f7d3-b3d3-1a68-5b99-75db195eb796@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/2016 11:30 AM, Dave Martin wrote:

>> The VL value is implicitly thread-local data, and the encoded state may have
>> an implicit dependency on it, although it does not contain vector registers
>> as such.
>
> This doesn't sound like an absolute requirement to me.
>
> If we presume that the SVE registers never need to get saved or
> restored, what stops the context data format being VL-independent?

I'm concerned the suspended computation has code which has been selected 
to fit a particular VL value.

 > If the save/restore logic doesn't touch SVE, which would its
 > implementation be VL-dependent?

Because it has been optimized for a certain vector length?

>>> Because the SVE procedure call standard determines that the SVE
>>> registers are caller-save,
>>
>> By the way, how is this implemented?  Some of them overlap existing
>> callee-saved registers.
>
> Basically, all the *new* state is caller-save.
>
> The Neon/FPSIMD regs V8-V15 are callee-save, so in the SVE view
> Zn[bits 127:0] is callee-save for all n = 8..15.

Are the extension parts of registers v8 to v15 used for argument passing?

If not, we should be able to use the existing dynamic linker trampoline.

Thanks,
Florian
