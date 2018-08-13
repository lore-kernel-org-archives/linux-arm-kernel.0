From: liu.song.a23@gmail.com (Song Liu)
Date: Mon, 13 Aug 2018 10:12:14 -0700
Subject: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180813131723.GC28360@redhat.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
 <CAPhsuW49+qA7kT7yE4tgbnAuox-iOzssg-jc2abG8XDo6XeX8A@mail.gmail.com>
 <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com>
 <20180813115019.GB28360@redhat.com>
 <fa85d19f-b22c-e09c-b8d2-f68f0c79de15@linux.ibm.com>
 <20180813131723.GC28360@redhat.com>
Message-ID: <CAPhsuW4KT=6vR_0ogTy_+Fwcz7cZ0Rac8sYohLngQmEBCd0HLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2018 at 6:17 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 08/13, Ravi Bangoria wrote:
>>
>> > But damn, process creation (exec) is trivial. We could add a new uprobe_exec()
>> > hook and avoid delayed_uprobe_install() in uprobe_mmap().
>>
>> I'm sorry. I didn't get this.
>
> Sorry for confusion...
>
> I meant, if only exec*( could race with _register(), we could add another uprobe
> hook which updates all (delayed) counters before return to user-mode.
>
>> > Afaics, the really problematic case is dlopen() which can race with _register()
>> > too, right?
>>
>> dlopen() should internally use mmap() right? So what is the problem here? Can
>> you please elaborate.
>
> What I tried to say is that we can't avoid uprobe_mmap()->delayed_uprobe_install()
> because dlopen() can race with _register() too, just like exec.
>
> Oleg.
>

How about we do delayed_uprobe_install() per file? Say we keep a list
of delayed_uprobe
in load_elf_binary(). Then we can install delayed_uprobe after loading
all sections of the
file.

Song
