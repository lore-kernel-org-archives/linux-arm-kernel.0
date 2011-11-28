From: rabin@rab.in (Rabin Vincent)
Date: Mon, 28 Nov 2011 22:34:15 +0530
Subject: [PATCH 4/4] ARM: add jump label support
In-Reply-To: <20111123175321.GI9581@n2100.arm.linux.org.uk>
References: <1321888429-3519-1-git-send-email-rabin@rab.in>
 <1321888429-3519-4-git-send-email-rabin@rab.in>
 <20111122194213.GC9581@n2100.arm.linux.org.uk>
 <4ECC2A07.8050701@codeaurora.org> <20111122233949.GA24453@redhat.com>
 <20111122235041.GB24453@redhat.com> <20111123145509.GA4973@debian>
 <20111123175321.GI9581@n2100.arm.linux.org.uk>
Message-ID: <CAH+eYFC6A7EeYV-C7fOnJcbMpQ009TNsmY+-QVK+n9zHn0PVkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 23:23, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Nov 23, 2011 at 08:25:09PM +0530, Rabin Vincent wrote:
>> +cat << "END" | $@ -x c - -c -o /dev/null >/dev/null 2>&1 && echo "y"
>> +int main(void)
>> +{
>> +#ifdef __arm__
>> + ? ? /*
>> + ? ? ?* Not related to asm goto, but used by jump label
>> + ? ? ?* and broken on some ARM GCC versions (see GCC Bug 48637).
>> + ? ? ?*/
>> + ? ? static struct { int dummy; int state; } tp;
>> + ? ? asm ("@ %c0" :: "i" (&tp.state));
>> +#endif
>> +
>> +entry:
>> + ? ? asm goto ("" :::: entry);
>> + ? ? return 0;
>> +}
>> +END
>
> Is the presence of asm goto and %c something we want to test together or
> separately? ?I suspect it's something we want to do separately.

Why would we want to do it separately?

The only reason I see is because the results of this test are assigned
to a variable called CC_HAVE_ASM_GOTO and that is not an entirely
accurate name (on ARM) after the addition of this test.  If that's the
concern, perhaps this variable could just be renamed?
