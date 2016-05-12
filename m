From: luke.starrett@broadcom.com (Luke Starrett)
Date: Thu, 12 May 2016 14:32:25 -0400
Subject: [PATCH] arm64: Implement optimised IP checksum helpers
In-Reply-To: <5734B899.3040207@arm.com>
References: <6ca77904d1eced60d86145dc5da361f3aefc6fec.1463062758.git.robin.murphy@arm.com>
 <a3d91ddf-565d-5cef-0a56-39154e3a00d2@broadcom.com>
 <5734B899.3040207@arm.com>
Message-ID: <49017ef4-1e96-3684-dec1-5f013724f8f2@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 5/12/2016 1:08 PM, Robin Murphy wrote:
> Hi Luke,
>
> On 12/05/16 16:34, Luke Starrett wrote:
>> Hi Robin,
>>
>> I pulled this in to a userspace test app expecting that the __uint128_t
>> type might cause GCC to emit 'ldp'.  Seems like that was that your
>> intent based on your commit note.  Instead I see two 64b loads (ldr Xn),
>> and a single 32b load (ldr Wn) for the trailing 4B.  This was with
>> Linaro GCC 4.9-2015.06.
>
> GCC 5 happily emits ldp there, but indeed I couldn't figure out how to 
> convince GCC 4 to do so. From a quick ferret around in the GCC Git, it 
> looks like the relevant optimisations may have only gone in post-4.9.
>
Not a problem.  I was just curious for my own selfish reasons.

>> Otherwise, the C cycle count looks good enough compared to the asm 
>> version.
>
> Yeah, compiling as standalone functions with GCC 5 I get 19 
> instructions vs. 17 for the asm, but the loop logic gets optimised out 
> completely when ihl is a compile-time constant (e.g. inet_gro_receive())
>

I updated to Linaro GCC 5.3-2016.02, and saw what you described.  I ran 
some smoke testing against a random header generator.  LGTM.

Acked-by: Luke Starrett <luke.starrett@broadcom.com>
