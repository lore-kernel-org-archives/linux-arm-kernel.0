From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Jun 2017 20:57:31 +0200
Subject: [PATCH] arm64: ftrace: fix building without CONFIG_MODULES
In-Reply-To: <20170609113850.GF13955@arm.com>
References: <20170609102807.2992510-1-arnd@arndb.de>
 <20170609113850.GF13955@arm.com>
Message-ID: <CAK8P3a10CQq3mvQzysTTk+y=WQ=zcXehjPDUXzqh8SnTZ6WkXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 9, 2017 at 1:38 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Arnd,
>
> On Fri, Jun 09, 2017 at 12:27:06PM +0200, Arnd Bergmann wrote:
>> When CONFIG_MODULES is disabled, we cannot dereference a module pointer:
>>
>> arch/arm64/kernel/ftrace.c: In function 'ftrace_make_call':
>> arch/arm64/kernel/ftrace.c:107:36: error: dereferencing pointer to incomplete type 'struct module'
>>    trampoline = (unsigned long *)mod->arch.ftrace_trampoline;
>>
>> Also, the within_module() function is not defined:
>>
>> arch/arm64/kernel/ftrace.c: In function 'ftrace_make_nop':
>> arch/arm64/kernel/ftrace.c:171:8: error: implicit declaration of function 'within_module'; did you mean 'init_module'? [-Werror=implicit-function-declaration]
>>
>> This addresses both by adding the appropriate stubs.
>>
>> Fixes: e71a4e1bebaf ("arm64: ftrace: add support for far branches to dynamic ftrace")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/arm64/include/asm/module.h | 6 ++++++
>>  arch/arm64/kernel/ftrace.c      | 2 +-
>>  include/linux/module.h          | 5 +++++
>>  3 files changed, 12 insertions(+), 1 deletion(-)
>
> I can't seem to reproduce this simply by disabling MODULES in defconfig.
> Could you share your .config, please?

This is the randconfig I used: https://pastebin.com/SfKBY7f8

      Arnd
