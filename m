From: gang.chen@asianux.com (Chen Gang)
Date: Mon, 28 Jan 2013 18:36:01 +0800
Subject: [Suggestion] ARM:kernel: memcpy, checking the length before copy.
Message-ID: <51065491.7040702@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell King:

in arch/arm/kernel/fiq.c:

  since the function set_fiq_handler is an EXPORT_SYMBOL function.
  do we need checking memory length, before copy ?
    (have to understand the madly using by outside users)

  if really it is, maybe also need provide the return value for failure.


  Regards

gchen.


 80 void set_fiq_handler(void *start, unsigned int length)
 81 {
 82 #if defined(CONFIG_CPU_USE_DOMAINS)
 83         memcpy((void *)0xffff001c, start, length);
 84 #else
 85         memcpy(vectors_page + 0x1c, start, length);
 86 #endif
 87         flush_icache_range(0xffff001c, 0xffff001c + length);
 88         if (!vectors_high())
 89                 flush_icache_range(0x1c, 0x1c + length);
 90 }
 91 
...

137 EXPORT_SYMBOL(set_fiq_handler);
