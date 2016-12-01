From: fweimer@redhat.com (Florian Weimer)
Date: Thu, 1 Dec 2016 10:21:03 +0100
Subject: [RFC PATCH 00/29] arm64: Scalable Vector Extension core support
In-Reply-To: <20161130135631.GK1574@e103592.cambridge.arm.com>
References: <20161130120654.GJ1574@e103592.cambridge.arm.com>
 <3e8afc5a-1ba9-6369-462b-4f5a707d8b8a@redhat.com>
 <20161130135631.GK1574@e103592.cambridge.arm.com>
Message-ID: <dbcd545f-1358-6a80-5a9f-3e4a3c93189a@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/2016 02:56 PM, Dave Martin wrote:

> If we do have distinct "set process VL" and "set thread VL" interfaces,
> then my view is that the former should fail if there are already
> multiple threads, rather than just setting the VL of a single thread or
> (worse) asynchronously changing the VL of threads other than the
> caller...

Yes, looks feasible to me.

>>> I'm not familiar with resumable functions/executors -- are these in
>>> the C++ standards yet (not that that would cause me to be familiar
>>> with them... ;)  Any implementation of coroutines (i.e.,
>>> cooperative switching) is likely to fall under the "setcontext"
>>> argument above.
>>
>> There are different ways to implement coroutines.  Stack switching (like
>> setcontext) is obviously impacted by non-uniform register sizes.  But even
>> the most conservative variant, rather similar to switch-based emulation you
>> sometimes see in C coroutine implementations, might have trouble restoring
>> the state if it just cannot restore the saved state due to register size
>> reductions.
>
> Which is not a problem if the variably-sized state is not part of the
> switched context?

The VL value is implicitly thread-local data, and the encoded state may 
have an implicit dependency on it, although it does not contain vector 
registers as such.

> Because the SVE procedure call standard determines that the SVE
> registers are caller-save,

By the way, how is this implemented?  Some of them overlap existing 
callee-saved registers.

> they are not live at any external function
> boundary -- so in cooperative switching it is useless to save/restore
> this state unless the coroutine framework is defined to have a special
> procedure call standard.

It can use the standard calling convention, but it may have selected a 
particular implementation based on the VL value before suspension.

Florian
