From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 4 Feb 2015 10:41:11 -0600
Subject: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
In-Reply-To: <20150204162536.GJ8656@n2100.arm.linux.org.uk>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <2422968.Es7R0p3loO@vostro.rjw.lan>
 <1422984576.18187.82.camel@deneb.redhat.com>
 <8901765.mLfPOCUyAN@vostro.rjw.lan>
 <20150204104832.GF8656@n2100.arm.linux.org.uk>
 <CAErSpo71fVU5mJgXnxMwiE_TUrNyfSYHo5RDF-=u2BK5grDYAw@mail.gmail.com>
 <20150204162536.GJ8656@n2100.arm.linux.org.uk>
Message-ID: <CAErSpo69LoS0P_bzJ2JJyF=H_YyJua85FCJ7DdMi2_na=aHRiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 4, 2015 at 10:25 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Feb 04, 2015 at 09:53:28AM -0600, Bjorn Helgaas wrote:
>> On Wed, Feb 4, 2015 at 4:48 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > Moreover, __weak is positively harmful when you consider it adds bloat
>> > and dead code - the overriden __weak function is left behind in the
>> > resulting final image.
>>
>> Huh, I didn't realize that.  Is that a linker bug, or is there some
>> reason the weak function has to be in the final image?  I tried a
>> trivial test on x86 with gcc-4.8.2/ld-2.24, and I think the weak
>> function text was omitted, but a string constant used only by the weak
>> function was included.
> ...
> The reason this happens is because normally, each function text is
> emitted into the .text section of the object file, one after each
> other.  When the image is linked, the linker copies the contents of
> the complete input section to the output file, and then resolves the
> symbolic information and relocations.

OK, that makes sense.  Thanks a lot for the detailed explanation!
