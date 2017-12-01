From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Fri, 1 Dec 2017 16:57:26 +0100
Subject: Essential get_user fix missing from 3.10 aarch64
Message-ID: <CAHmME9qtH1ywCS+4ebg8myxWsAUbcqG6Rcus+Nt0DBLLaMu4wQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi stable/arm/Willy,

1f65c13efef69b6dc908e588f91a133641d8475c is an important commit,
because it involves evaluation of pointers from userspace. I'm running
into issues with RNDADDTOENTCNT reading bogus values, because p is
incremented twice as much as it should in this random.c block:

        case RNDADDENTROPY:
               if (!capable(CAP_SYS_ADMIN))
                       return -EPERM;
               if (get_user(ent_count, p++))
                       return -EFAULT;
               if (ent_count < 0)
                       return -EINVAL;
               if (get_user(size, p++))
                       return -EFAULT;
               retval = write_pool(&input_pool, (const char __user *)p,
                                   size);

That seems reasonable, but on aarch64, get_user is defined as:

#define get_user(x, ptr)                                                \
({                                                                      \
       might_sleep();                                                  \
       access_ok(VERIFY_READ, (ptr), sizeof(*(ptr))) ?                 \
               __get_user((x), (ptr)) :                                \
               ((x) = 0, -EFAULT);                                     \
})

Notice the multiple use of ptr.

I thought I had found something breathtakingly bad, until I realized
that it was already fixed in 2013 by Takahiro. It just wasn't marked
for stable.

Not sure if there's ever going to be another stable 3.10 release, but
if so, this would be an important one to backport.

Regards,
Jason
