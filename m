From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 2 Aug 2016 19:51:45 -0700
Subject: "Failed to create /dev/root: -14" after commit e6978e4bf1 ("ARM: save
 and reset the address limit when entering an exception")
Message-ID: <57A15C41.6000804@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I see the following crash when running a qemu arm 'kzm' runtime test with the current mainline.

Failed to create /dev/root: -14

[ followed by panic ]

A complete log file is at [1].

Bisect points to commit e6978e4bf1 ("ARM: save and reset the address limit when entering
an exception"). Some additional debugging shows lots of similar error returns from
strncpy_from_user(). For the error case resulting in the crash, the call chain
is as follows.

sys_mknod
   sys_mknodat()
     user_path_create()
       getname()
         getname_flags()
           strncpy_from_user()

Reverting the patch fixes the problem.

I don't see the problem with any other qemu arm test.

It looks like the kernel runs in exception context. My gut feeling is that qemu may be
to blame, but I am not really sure.

Any idea how to track this down ?

Thanks,
Guenter


---
[1] http://kerneltests.org/builders/qemu-arm-master/builds/615
