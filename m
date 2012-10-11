From: vipin.kumar@st.com (Vipin Kumar)
Date: Thu, 11 Oct 2012 09:47:03 +0530
Subject: [PATCH 09/11] fsmc/nand:FIX: replace change_bit routine
In-Reply-To: <alpine.LFD.2.02.1210101559250.16518@xanadu.home>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <ec169eb041e87e66c06108e85ea4a67e5797cecc.1349778821.git.vipin.kumar@st.com>
 <CACRpkdaot3DKCoJOBpUcJFVrJ89xRx2T58fDe4YKY_r4NFqEag@mail.gmail.com>
 <alpine.LFD.2.02.1210101559250.16518@xanadu.home>
Message-ID: <5076483F.5000102@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2012 1:51 AM, Nicolas Pitre wrote:
> On Wed, 10 Oct 2012, Linus Walleij wrote:
>
>> On Tue, Oct 9, 2012 at 12:44 PM, Vipin Kumar<vipin.kumar@st.com>  wrote:
>>
>>> change_bit routine accepts only ulong pointers as buffer, so an unaligned char
>>> pointer passed to change_bit may lead to a crash.
>>>
>>> Fix this bug by accessing the buffer as char pointer.
>>
>> Why not see if we can fix change_bit() instead?
>> Since I suspect this is on ARM I bet Russell and Nico
>> want to hear about this if there is a problem.
>>
>> Can the ARM change_bit() not be fixed, so that
>> long arguments are the only option?
>

Hello Nicolas

> No.  It is this code which is totally broken.
>

Yes, I understand and accept the probelm. That's why the fix

> The change_bit() is defined to operate on long values, in the _native_
> endian.  Now imagine what this is going to do to your data buffer if
> instead you are running on a big endian device.
>
> And I doubt there is anything requiring atomic bit manipulation here
> either.
>

No, there is no requirement for an atomic change_bit

>>>                  if (err_idx[i]<  chip->ecc.size * 8) {
>>> -                       change_bit(err_idx[i], (unsigned long *)dat);
>>> +                       uint8_t *p = dat + err_idx[i] / 8;
>>> +                       *p = *p ^ (1<<  (err_idx[i] % 8));
>>
>> I'm one of these people who would write>>3 and
>> &7 rather than /8 or %8 but I guess we are all
>> different. Atleast consider it if you stick with this...
>
> Better yet:
>
> 		dat[err_idx[i] / 8] ^= (1<<  (err_idx[i] % 8));
>
> The /8 and %8 will be changed into>>3 and&7 by the compiler anyway,
> while the /8 and %8 form is possibly a bit less obscure.
>

Yes, that's exactly why I kept /8 and %8. I would change the code as 
suggested by you

> Of course, this needs to be done over _all_ this driver, not only a few
> cases.
>

There is only one place which needs a change_bit. I would send a v2 with 
the suggested change

Vipin

>
> Nicolas
> .
>
