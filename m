From: will.deacon@arm.com (Will Deacon)
Date: Fri, 3 Aug 2018 10:23:13 +0100
Subject: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
In-Reply-To: <CACT4Y+aZtph5qDsLzTDEgpQRz4_Vtg1DD-cB18qooi6D0bexDg@mail.gmail.com>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180628105057.GA26019@e103592.cambridge.arm.com>
 <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
 <20180629110709.GA17859@arm.com>
 <CAAeHK+wHd8B2nhat-Z2Y2=s4NVobPG7vjr2CynjFhqPTwQRepQ@mail.gmail.com>
 <20180703173608.GF27243@arm.com>
 <CAAeHK+wTcH+2hgm_BTkLLdn1GkjBtkhQ=vPWZCncJ6KenqgKpg@mail.gmail.com>
 <CAAeHK+xc1E64tXEEHoXqOuUNZ7E_kVyho3_mNZTCc+LTGHYFdA@mail.gmail.com>
 <20180801163538.GA10800@arm.com>
 <CACT4Y+aZtph5qDsLzTDEgpQRz4_Vtg1DD-cB18qooi6D0bexDg@mail.gmail.com>
Message-ID: <20180803092312.GA17798@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2018 at 06:52:09PM +0200, Dmitry Vyukov wrote:
> On Wed, Aug 1, 2018 at 6:35 PM, Will Deacon <will.deacon@arm.com> wrote:
> > Thanks for tracking these cases down and going through each of them. The
> > obvious follow-up question is: how do we ensure that we keep on top of
> > this in mainline? Are you going to repeat your experiment at every kernel
> > release or every -rc or something else? I really can't see how we can
> > maintain this in the long run, especially given that the coverage we have
> > is only dynamic -- do you have an idea of how much coverage you're actually
> > getting for, say, a defconfig+modules build?
> >
> > I'd really like to enable pointer tagging in the kernel, I'm just still
> > failing to see how we can do it in a controlled manner where we can reason
> > about the semantic changes using something other than a best-effort,
> > case-by-case basis which is likely to be fragile and error-prone.
> > Unfortunately, if that's all we have, then this gets relegated to a
> > debug feature, which sort of defeats the point in my opinion.
> 
> Well, in some cases there is no other way as resorting to dynamic testing.
> How do we ensure that kernel does not dereference NULL pointers, does
> not access objects after free or out of bounds? Nohow. And, yes, it's
> constant maintenance burden resolved via dynamic testing.

... and the advantage of NULL pointer issues is that you're likely to see
them as a synchronous exception at runtime, regardless of architecture and
regardless of Kconfig options. With pointer tagging, that's certainly not
the case, and so I don't think we can just treat issues there like we do for
NULL pointers.

Will
