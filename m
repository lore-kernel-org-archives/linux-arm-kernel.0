From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 19 Jan 2015 21:01:57 +0100
Subject: [PATCH] i2c: drop ancient protection against sysfs refcounting
 issues
In-Reply-To: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
References: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
Message-ID: <54BD62B5.7050205@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/19/2015 07:55 PM, Wolfram Sang wrote:
[...]
>
> Let's get rid of this code before really nobody knows/understands
> anymore what this was for and if it has a subtle use.

Getting rid of this is the right thing, cause it's just not how it should be 
done, but unfortunately it is not as simple as this. The problem is that the 
adapter is typically embedded in the parent device's state struct. This state 
struct is typically freed directly after calling i2c_del_adapter(). If there is 
still something holding a reference to the adapter this will result in a use 
after free. To do this properly i2c_add_adapter() needs to be changed to 
i2c_alloc_adapter() that returns a pointer to a newly allocated adapter. 
i2c_free_adapter() will then only drop a reference to the adapter, but not free 
any memory. Once the last reference has been removed the memory can then be 
freed in the release callback.

The other issue is as long as something has a reference to the adapter they can 
run operations on the adapter. So freeing the adapter also has to make sure 
that any further operations that are performed on the adapter do no longer call 
into the device specific ops, but rather returns -ENODEV, or similar.

- Lars
