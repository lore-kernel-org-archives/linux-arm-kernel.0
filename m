From: ndesaulniers@google.com (Nick Desaulniers)
Date: Thu, 3 Aug 2017 10:53:12 -0700
Subject: [PATCH] arm64: avoid overflow in VA_START and PAGE_OFFSET
In-Reply-To: <CAKv+Gu-sKku1R6RQHoRsoskk+n5ns+4BfChH7gvR-JCmksdVsA@mail.gmail.com>
References: <20170803132035.gixd7m7oxtehpquu@yury-thinkpad>
 <20170803171117.107992-1-ndesaulniers@google.com>
 <CAKv+Gu-sKku1R6RQHoRsoskk+n5ns+4BfChH7gvR-JCmksdVsA@mail.gmail.com>
Message-ID: <CAKwvOdk1A-wvuNDaLokYu1oNPUV-ab24=NzdL5Sbh6QcV_vDMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Would
>
> #define VA_START (UL(0xffffffffffffffff) - (1 << VA_BITS) + 1)
>
> also work?

I think you'd have to wrap the 1 in a UL(), ex:

#define VA_START (UL(0xffffffffffffffff) - (UL(1) << VA_BITS) + 1)

Otherwise IIUC a integral literal (`1`) is treated as an int, which on
arm64 is LP64 making it 32b, where most configs set VA_BITS
to larger than 32b.  Shifting by more than the width is undefined
behavior. And without it, I get compile errors.

I'll send v2 with your suggestion, thanks.
-- 
Thanks,
~Nick Desaulniers
