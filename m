From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Sat, 24 Sep 2011 13:14:41 +0300
Subject: I-cache/D-cache inconsistency issue with page cache
In-Reply-To: <20110924093544.GA5724@glandium.org>
References: <20110923115721.GA7013@glandium.org>
	<20110923193941.GQ17169@n2100.arm.linux.org.uk>
	<20110924093544.GA5724@glandium.org>
Message-ID: <CACY+gR0cbZ+5YQs2dm2fFQqn=SGnj=akWpnuvJXPg5VWDg+i5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 24, 2011 at 12:35 PM, Mike Hommey <mh@glandium.org> wrote:
> On Fri, Sep 23, 2011 at 08:39:41PM +0100, Russell King - ARM Linux wrote:
>> On Fri, Sep 23, 2011 at 01:57:21PM +0200, Mike Hommey wrote:
>> > We've been hitting random crashes at startup with Firefox on tegras
>> > (under Android), and narrowed it down to a I-cache/D-cache
>> > inconsistency. A reduced testcase of the issue looks like the following
>> > (compile as ARM, not Thumb):
>>
>> If you write code at run time, you need to use the sys_cacheflush
>> API to ensure that it's properly synchronized with the I-cache. ?It's
>> a well known issue, and it applies to any harvard cache structured
>> CPU which doesn't automatically ensure coherence (which essentially
>> means all ARMs.)
>
> I do agree it's reasonable to have applications doing that to handle
> cache synchronization themselves. I wrote such in my message. But I
> think the kernel should make sure that its page cache is fresh when
> it maps it PROT_EXEC. I think it's unreasonable to expect applications
> doing mmap(PROT_WRITE), inflate, munmap, something, mmap(PROT_EXEC),
> and execute something there to have to handle cache synchronisation
> themselves. Especially when it's very CPU dependent (the testcase does
> not even fail on all ARMs, only tegras, apparently). I'm not talking
> actual code generation here, which needs platform-dependent behaviour.

Unfortunately we can't rely on what is reasonable, but have to
strictly follow how it is specified to work. My understanding is that
'sys_cacheflush' has been always mandatory for arm linux and
orthogonal to 'mmap'/'mprotect', no matter what discussion threads you
find in the mailing list archives. Being new to ARM architecture at
that time, I had been also burned by this issue years ago [1], when
various pieces of documentation did not match each other, there was a
transition from OABI to EABI ongoing, etc.

The way forward could be to try and ask linux man pages maintainers to
update the entries for 'mmap' and 'mprotect' to explicitly state that
certain architectures require mandatory instruction/data caches
synchronization no matter how you play with the protection flags, and
that it can be usually done via gcc '__builtin___clear_cache' function
[2].

1. http://ffmpeg.org/pipermail/ffmpeg-devel/2007-January/027847.html
2. http://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html

-- 
Best regards,
Siarhei Siamashka
