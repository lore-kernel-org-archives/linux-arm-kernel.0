From: dhylands@gmail.com (Dave Hylands)
Date: Mon, 20 Jun 2011 01:58:17 -0700
Subject: Problems with semaphores, mutexes, and atomic?
In-Reply-To: <20110620082729.GA26089@n2100.arm.linux.org.uk>
References: <BANLkTikwGgrK0FFiee1a8PvDicJa-bUedg@mail.gmail.com>
	<20110620082729.GA26089@n2100.arm.linux.org.uk>
Message-ID: <BANLkTinzRg+bu4AB4JGYkY_y9g8ZRhV=JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Jun 20, 2011 at 1:27 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Jun 19, 2011 at 11:39:49PM -0700, Dave Hylands wrote:
>> Each thread performs the loop a number of times, and at the end the
>> count often doesn't have the expected value if the locks were in fact
>> atomic.
>>
>> Typical output looks like:
>>
>> 192.168.0.50 ?~ # modprobe test-mutex
>> [ ? 26.220000] Testing mutex...
>> [ ? 26.230000] ? ? Launching threads ..........
>> [ ? 26.300000] ? ? Waiting for threads to finish ..........
>> [ ? 26.310000] ? counter = 999888 FAIL
>> [ ? 26.310000] Testing semaphore...
>> [ ? 26.310000] ? ? Launching threads ..........
>> [ ? 26.440000] ? ? Waiting for threads to finish ..........
>> [ ? 27.810000] ? counter = 999575 FAIL
>> [ ? 27.810000] Testing atomic...
>> [ ? 27.820000] ? ? Launching threads ..........
>> [ ? 28.030000] ? ? Waiting for threads to finish ..........
>> [ ? 28.040000] ?counter = 9910929 FAIL
>
> The answer is quite simple. ?You're not waiting for all the threads to
> finish. ?The first down(&thread_wait) will succeed, so the values you're
> getting above could be up to 100000 (NUM_ATOMIC_ITER) out. ?And they
> are.

Thank you. My sanity has been restored.

I added a down on thread_wait in the init routine, and now all of test
cases pass for all of the variations (CONFIG_SMP=n, CONFIG_SMP=y, with
1 or 2 processors).

Now I need to dig deeper to find the real reason why my original code,
which prompted me to go down this path is failing.

-- 
Dave Hylands
Shuswap, BC, Canada
http://www.davehylands.com
