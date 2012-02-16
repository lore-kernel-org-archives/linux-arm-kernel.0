From: a.p.zijlstra@chello.nl (Peter Zijlstra)
Date: Thu, 16 Feb 2012 17:19:43 +0100
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <CACVXFVM472hz+na7o2wJr1CPq-W=YB7i0UwtrsUf62+ryzWp8A@mail.gmail.com>
References: <CAMQu2gzfNAwtf1c6jrTZpfGMSqBgBrQKmFTeCFzbvMh9ESBDUg@mail.gmail.com>
 <CAMsRxfKR1ODH56BtcUT5Dv6qOVEYGVheEcW9ugXsZmLKok==bg@mail.gmail.com>
 <CAMQu2gwWt6oQPjxc1YHgOoxVkHdck_q78Xf==7ncwRj0_uS-JQ@mail.gmail.com>
 <CAMQu2gyCPtbNfBa5V8ve2JORN+sDeAY+hvR0g0_9U354JgcuiA@mail.gmail.com>
 <CAMsRxfJVEgVJoHcaPQbMg5mwz=tZUce4oibDUxtnevSF8bGY9g@mail.gmail.com>
 <CAMQu2gxVUqDF2HkPD=QeX0N_tUd=9FTd+T+1LHCR0tsCgQxC8Q@mail.gmail.com>
 <CAMsRxfJH+9MS=Svmh0BvDSb8xqsPe2HPobkeKcn8JO35npjhwQ@mail.gmail.com>
 <CACVXFVMx9Zx3ZQr6Q-17x5NVL8iuBJjOjtw39FJiWX=fGkZNZA@mail.gmail.com>
 <1329323900.2293.150.camel@twins>
 <CACVXFVPce0A3LfL=mFo3UbN-Om7xLOo_d-LfKXDjdN5dFQdhiA@mail.gmail.com>
 <20120216150004.GE2641@mudshark.cambridge.arm.com>
 <CACVXFVM472hz+na7o2wJr1CPq-W=YB7i0UwtrsUf62+ryzWp8A@mail.gmail.com>
Message-ID: <1329409183.2293.245.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-02-17 at 00:12 +0800, Ming Lei wrote:
> is triggered: u64 delta = 100 -  1000000 = 18446744073708551716.

on x86 we do:

  int shift = 64 - x86_pmu.cntval_bits;
  s64 delta;

  delta = (new_raw_count << shift) - (prev_raw_count << shift);
  delta >>= shift;

This deals with short overflows (on x86 the registers are typically 40
or 48 bits wide). If the arm register is 32 you can of course also get
there with some u32 casts.
