From: arjanvandeven@gmail.com (Arjan van de Ven)
Date: Tue, 24 Feb 2015 01:39:46 -0800
Subject: [PATCH 0/7] Serialise oopses, BUGs, WARNs, dump_stack, soft
 lockups and hard lockups
In-Reply-To: <20150224063513.GA15387@gmail.com>
References: <1424748634-9153-1-git-send-email-anton@samba.org>
 <20150224063513.GA15387@gmail.com>
Message-ID: <CADyApD06_0uf4QgGVWRQyBP9pb2VRQnCOGK7M7K9kTti52usoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Some architectures already have their own recursive
>> locking for oopses and we have another version for
>> serialising dump_stack.
>>
>> Create a common version and use it everywhere (oopses,
>> BUGs, WARNs, dump_stack, soft lockups and hard lockups).
>
> Dunno. I've had cases where the simultaneity of the oopses
> (i.e. their garbled nature) gave me the clue about the type
> of race to expect.
>


one of the question is if you want to serialize, or if you just want to label.
If you take a cookie (could just be a monotonic increasing number) at
the start of the oops
and then prefix/postfix the stack printing with that number, you don't
serialize (risk of locking up),
but you can pretty trivially see which line  came from where..
if you do the monotonic increasing number approach, you even get an
ordering out of it.
it does mean changing the dump_stack() and co function fingerprint to
take an extra argument,
but that is not TOO insane.
