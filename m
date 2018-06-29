From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 29 Jun 2018 11:14:35 +0100
Subject: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
In-Reply-To: <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180628105057.GA26019@e103592.cambridge.arm.com>
 <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
Message-ID: <20180629101435.263hujat2amnm3hi@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 08:56:41PM +0200, Andrey Konovalov wrote:
> On Thu, Jun 28, 2018 at 12:51 PM, Dave Martin <Dave.Martin@arm.com> wrote:
> > On Tue, Jun 26, 2018 at 03:15:10PM +0200, Andrey Konovalov wrote:
> >> 1. By using the Top Byte Ignore arm64 CPU feature, we can store pointer
> >>    tags in the top byte of each kernel pointer.
> >
> > [...]
> >
> > This is a change from the current situation, so the kernel may be
> > making implicit assumptions about the top byte of kernel addresses.

[...]

> > What was your approach to tracking down all the points in the code
> > where we have a potential issue?
> 
> I've been fuzzing the kernel built with KWHASAN with syzkaller. This
> gives a decent coverage and I was able to find some places where
> fixups were required this way. Right now the fuzzer is running without
> issues. It doesn't prove that all such places are fixed, but I don't
> know a better way to test this.

While fuzzing shows that the kernel doesn't crash (and this is very
important), it does not show that it exhibits the expected behaviour,
and there could be a number of soft failures present.

e.g. certain functions might just return an error code if a pointer has
a tag other than 0xff (such that it looks like a kernel pointer) or 0x00
(such that it looks like a user pointer), and this might not result in a
fatal error even though the behaviour is not what we require.

Perhaps it's possible to compare the behaviour of a kernel making use of
tags with one which does not, though I'm not sure at which level the
comparison needs to be performed.

Thanks,
Mark.
