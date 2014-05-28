From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 28 May 2014 16:09:15 +0200
Subject: [PATCH v3 14/14] ARM64: KVM: fix big endian issue in
 access_vm_reg for 32bit guest
In-Reply-To: <CAA3XUr3=jeNqP6FMSki8Mij-ENu7X+nBRrQ2p_bUODw_9jmgog@mail.gmail.com>
References: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
 <1399997646-4716-15-git-send-email-victor.kamensky@linaro.org>
 <20140526175225.GF31431@lvm>
 <CAA3XUr15fJu3vRU3Hq=fajiRCd1gvkdmvJfsa3Te4N-3puwcWA@mail.gmail.com>
 <20140528091438.GL16428@lvm>
 <CAA3XUr3=jeNqP6FMSki8Mij-ENu7X+nBRrQ2p_bUODw_9jmgog@mail.gmail.com>
Message-ID: <20140528140915.GB38250@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 06:56:44AM -0700, Victor Kamensky wrote:
> On 28 May 2014 02:14, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > On Tue, May 27, 2014 at 11:11:57PM -0700, Victor Kamensky wrote:
> >> On 26 May 2014 10:52, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> >> > On Tue, May 13, 2014 at 09:14:06AM -0700, Victor Kamensky wrote:

[...]

> >> > But I think the thing that bothers me in general with all these patches
> >> > is that they deal specially with a lot of situations where the data
> >> > structure was designed specifically to make the code easy to read, and
> >> > now it just becomes a really complicated mess.  Have you carefully
> >> > considered other options, redesigning the data structure layout etc.?
> >>
> >> I have considered different options and I am open for
> >> suggestions. Bytesswaps quite often could be done in different
> >> places but achieve the same result. In several cases I initially
> >> developed patch that deals with BE issue in one way and
> >> reworked to make it more compact less intrusive. For example
> >> in this particular case order of high and low words of 64bit cp15
> >> register could be kept the same in BE/LE cases but code that
> >> save/restore it could be changed to do byteswap. My opinion
> >> that proposed option is more clean.
> >>
> > What I was thinking is to avoid packing 64-bit values as two 32-bit
> > values, so for example having two separate arrays on the kvm_cpu_context
> > struct, one for 32-bit coprocessor registers and one for 64-bit
> > coprocessor registers.
> 
> They cannot be separate it is the same data with two ways
> to access: as 64bit value or low word 32bit value. Typically it is LPAE
> cp15 memory related registers like TTBR0, as in mcrr, mcr example
> in my previous response. mcrr will update high and low word values
> of TTBR0, mcr will update only low word of it.
> 
You just have to decide whether you want to represent a 64-bit register as
a concatenation of two u32's or a 32-bit register access as a part
of the 64-bit register value.

I think the architecture, at least for 32-bit register views on ARMv8,
defines the 32-bit accesses as a view on the 64-bit register.

You should of course only store those registers once, but instead of
storing them in an array of u32's you could store the 64-bit wide
registers in a separate array of u64's.  32-bit accesses to those
registers would look in the array of u64's for such a value.

I didn't try it out, so not sure how it looks like, just saying it's an
option worth considering.

-Christoffer
