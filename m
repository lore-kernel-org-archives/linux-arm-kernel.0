From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Sep 2012 16:13:56 +0200
Subject: [PATCH 1/2] spi:pl022: Disable/Enable functional clock from
 suspend/resume
In-Reply-To: <CAOh2x==aZbqYpPHvWyY7ReVi90TJAHbMLbk17o8wAOh+swbxzw@mail.gmail.com>
References: <1348658647-25975-1-git-send-email-vipulkumar.samar@st.com>
 <1348658647-25975-2-git-send-email-vipulkumar.samar@st.com>
 <CACRpkdampxUw0=NO6cs679C-r0_AnPEaTYVc+GppRkKGn32p-w@mail.gmail.com>
 <20120926121946.GO4428@opensource.wolfsonmicro.com>
 <CAOh2x==aZbqYpPHvWyY7ReVi90TJAHbMLbk17o8wAOh+swbxzw@mail.gmail.com>
Message-ID: <CACRpkdZccTHjQ=jwZ=hhCgzv0LyNDyGBpfGzPg9Zk2wqzmZqCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2012 at 4:08 PM, viresh kumar <viresh.kumar@linaro.org> wrote:
> On Wed, Sep 26, 2012 at 5:49 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Wed, Sep 26, 2012 at 02:17:36PM +0200, Linus Walleij wrote:
>>> On Wed, Sep 26, 2012 at 1:24 PM, Vipul Kumar Samar
>>
>>> > SPI functional clock must be disalble/enable in non RTPM suspend/resume
>>> > hooks. Currently it is only done for RTPM cases.
>>
>>> > This patch add support to disable/enbale clock for conventional
>>> > suspend/resume calls.
>>
>>> Cross dependency between runtime suspend/resume and
>>> common suspend/resume. Oh the horror ...
>>
>> This should be fine, we runtime resume before we suspend.
>
> I believe Vipul sent this patch for the cases where RTPM in not
> enabled in the configs.

OK so we need to handle the cases where either, both or
just one of them is enabled...

Mark says the defined semantics is that runtime PM is
resumed across suspend/resume but I'd just like to
understand the overall mechanism that makes sure
this happens and I'm go...

However there is another problem with the patch,
because in -next there is also pin control handling
in the runtime hooks, so we need to duplicate
not only clocks but also that in each of the functions.

Maybe we can first make a patch that breaks out
resource handling so we can call that from each
of the suspend/resume calls? (I'll try.)

Yours,
Linus Walleij
