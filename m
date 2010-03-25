From: anti.sullin@artecdesign.ee (Anti Sullin)
Date: Thu, 25 Mar 2010 15:09:46 +0200
Subject: [patch v3 2/3] at91_udc HW glitch
In-Reply-To: <6681f8e11003250503k20efc864ve6d916ad5a7c67b2@mail.gmail.com>
References: <20100203143736.564974126@gmail.com>	
	<20100203143803.528679118@gmail.com>	
	<cd73a99e1003231326r7623bbc0icba163f9b2e0e96e@mail.gmail.com>
	<6681f8e11003250503k20efc864ve6d916ad5a7c67b2@mail.gmail.com>
Message-ID: <4BAB609A.9030407@artecdesign.ee>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Harro Haan wrote:
> On 23 March 2010 21:26, Andrew Victor <avictor.za@gmail.com> wrote:
>> The at91_udc driver does not seem to do that for its CSR register writes.
>> So I was wondering if we implement what the datasheet says, would we
>> still need the "fix" above.

Another read is still needed after verifying that the flag is changed.

We are writing a bit that does not have a register behind it. It just
triggers the acknowledge that the data has been read.
We could poll if the corresponding data ready flag is cleared to check
if the write has propagated. But this leads to another problem:
the reads do not seem to be re-syncronized between clock domains.
We just get what is there at the moment the read is performed. This
means that even if the "data ready" bit is cleared, we could not be sure
at that moment that the rest of the changes have been performed
that were triggered by the same write. We even get reads, where
some bits in rx data counter have changed and some bits are old.
So to be fully sure, we should wait until the bit has been cleared
and then perform another read to be sure that the rest of the bits
have been changed as well. See my 2009-03-25 17:08 e-mail for details.
